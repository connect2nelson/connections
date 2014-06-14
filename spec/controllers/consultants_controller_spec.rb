require 'rails_helper'

RSpec.describe ConsultantsController, :type => :controller do

  describe 'show GET' do

    #ENV["SECURITY_ENABLED"] = "enabled"

    let(:consultant) {Consultant.new(employee_id: "1")}

    it 'should show user' do
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id})
      get :show, Hash[id: consultant.employee_id]
    end

    it 'should assign user' do
      expect(Consultant).to receive(:find_by).with({:employee_id=>consultant.employee_id}).and_return consultant
      get :show, Hash[id: consultant.employee_id]
      expect(assigns(:consultant)).to eq consultant
    end

    it "should not assign user if not authenticated" do
      ENV["SECURITY_ENABLED"] = "ENABLED"
      get :show, Hash[id: consultant.employee_id]
      response.should redirect_to("/auth/saml")
    end

  end

end
