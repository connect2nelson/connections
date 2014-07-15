require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do
 controller do
    def index
      render :nothing => true
    end
  end
  describe "handling security" do
     it "should redirect to authentication if not authenticated" do
      ENV["SECURITY_ENABLED"] = "ENABLED"
      get :index
      expect(response).to redirect_to("/auth/saml")
      expect(response.location).to include "/auth/saml"
    end

    after {ENV["SECURITY_ENABLED"] = nil}
  end
end