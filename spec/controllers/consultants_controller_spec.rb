require 'rails_helper'

RSpec.describe ConsultantsController, :type => :controller do

  describe 'show GET' do

    #ENV["SECURITY_ENABLED"] = "enabled"

    consultant = Consultant.new(employee_id: '1')
    let(:consultant) {consultant}
    let(:mentors) {[Connection.new(Consultant.new, consultant)]}
    let(:mentees) {[Connection.new(consultant, Consultant.new)]}
    let(:contact) {Contact.new(employee_id: '1', github_account: 'yo')}
    let(:peers) {[Connection.new(consultant, Consultant.new)]}

    it 'should show user' do
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      get :show, Hash[id: consultant.employee_id]
    end

    it 'should assign user' do
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      get :show, Hash[id: consultant.employee_id]
      expect(assigns(:consultant)).to eq consultant
    end

    it 'should assign mentors' do
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      expect(ConnectionService).to receive(:best_mentors_for).with(consultant).and_return mentors
      get :show, Hash[id: consultant.employee_id]
      expect(assigns(:mentors)).to eq mentors
    end

    it 'should assign mentees' do
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      expect(ConnectionService).to receive(:best_mentees_for).with(consultant).and_return mentees
      get :show, Hash[id: consultant.employee_id]
      expect(assigns(:mentees)).to eq mentees
    end

    it 'should assign sponsees' do
      sponsees = [Connection.new(consultant, Consultant.new(employee_id: '2'))]
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      expect(SponsorshipService).to receive(:get_sponsees_for).with(consultant).and_return sponsees

      get :show, Hash[id: consultant.employee_id]
      expect(assigns(:sponsees)).to eq sponsees
    end

    it 'should assign sponsors' do
      sponsors = [Connection.new(consultant, Consultant.new(employee_id: '2'))]
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      expect(SponsorshipService).to receive(:get_sponsors_for).with(consultant).and_return sponsors

      get :show, Hash[id: consultant.employee_id]
      expect(assigns(:sponsors)).to eq sponsors
    end

    it 'should assign peers' do
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      expect(ConnectionService).to receive(:best_peers_for).with(consultant).and_return peers

      get :show, Hash[id: consultant.employee_id]
      expect(assigns(:peers)).to eq peers
    end

    it 'should assign contact' do
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      expect(ContactService).to receive(:contacts_for).with(consultant).and_return contact

      get :show, Hash[id: consultant.employee_id]
      expect(assigns(:contact)).to eq contact
    end

    it 'should remove sponsees from the recommended mentees list' do
      sponsee_in_mentees = Connection.new(consultant, Consultant.new(employee_id: 2))
      mentees = [Connection.new(consultant, Consultant.new(employee_id: 4)), sponsee_in_mentees]
      sponsees = [sponsee_in_mentees]
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      expect(SponsorshipService).to receive(:get_sponsees_for).with(consultant).and_return sponsees
      expect(ConnectionService).to receive(:best_mentees_for).with(consultant).and_return mentees

      get :show, Hash[id: consultant.employee_id]
      expect(assigns(:mentees).size).to eq 1
      expect(assigns(:mentees)[0].mentee.employee_id).to eq "4"
    end

    it 'should remove sponsors from the recommended mentors list' do
      sponsor_in_mentors = Connection.new(Consultant.new(employee_id: 2), consultant)
      mentors = [Connection.new(Consultant.new(employee_id: 4), consultant), sponsor_in_mentors]
      sponsors = [sponsor_in_mentors]
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      expect(SponsorshipService).to receive(:get_sponsors_for).with(consultant).and_return sponsors
      expect(ConnectionService).to receive(:best_mentors_for).with(consultant).and_return mentors

      get :show, Hash[id: consultant.employee_id]
      expect(assigns(:mentors).size).to eq 1
      expect(assigns(:mentors)[0].mentor.employee_id).to eq "4"
    end

  end

  describe 'GET #index' do
    before { ENV["SECURITY_ENABLED"] = nil }

    context 'no search' do
      it 'should render index template' do
        get :index
        expect(response).to render_template :index
      end

      it 'should not assign search_results' do
        get :index
        expect(assigns(:search_results)).to be_nil
      end
    end

    context 'with search' do
      let(:consultant) { Consultant.new }
      let(:consultants) { [consultant] }
      before do
        allow(Consultant).to receive(:where).with(full_name: /Derek/i).and_return consultants
      end

      it 'should render index template' do
        get :index, full_name: 'Derek'
        expect(response).to render_template :index
      end

      it 'should not assign search_results' do
        get :index, full_name: 'Derek'
        expect(assigns(:search_results)).to eq consultants
      end
    end
  end
end
