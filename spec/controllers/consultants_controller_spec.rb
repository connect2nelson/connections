require 'rails_helper'

RSpec.describe ConsultantsController, :type => :controller do

  describe 'show GET' do

    #ENV["SECURITY_ENABLED"] = "enabled"

    consultant = Consultant.new(employee_id: '1')
    let(:consultant) {consultant}
    let(:mentors) {[Connection.new(Consultant.new, consultant)]}
    let(:mentees) {[Connection.new(consultant, Consultant.new)]}
    sponsee = Connection.new(consultant, Consultant.new(employee_id: '2'))
    let(:sponsees) {[sponsee]}
    let(:contact) {Contact.new(employee_id: '1', github_account: 'yo')}

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
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      expect(SponsorshipService).to receive(:get_sponsees_for).with(consultant).and_return sponsees
      get :show, Hash[id: consultant.employee_id]
      expect(assigns(:sponsees)).to eq sponsees
    end

    it 'should assign contact' do
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      expect(ContactService).to receive(:contacts_for).with(consultant).and_return contact

      get :show, Hash[id: consultant.employee_id]
      expect(assigns(:contact)).to eq contact
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
