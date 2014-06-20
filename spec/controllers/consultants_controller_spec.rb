require 'rails_helper'

RSpec.describe ConsultantsController, :type => :controller do

  describe 'show GET' do

    #ENV["SECURITY_ENABLED"] = "enabled"

    let(:consultant) {Consultant.new(employee_id: "1")}
    let(:mentors) {[Connection.new(Consultant.new, consultant)]}
    let(:mentees) {[Connection.new(consultant, Consultant.new)]}

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

    it "should not assign user if not authenticated" do
      ENV["SECURITY_ENABLED"] = "ENABLED"
      get :show, Hash[id: consultant.employee_id]
      response.should redirect_to("/auth/saml")
      expect(response.location).to include "/auth/saml"
    end
  end
end
