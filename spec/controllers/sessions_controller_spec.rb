require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
	describe "session creation and destruction" do
		it "should redirect to home with authentication on for creation of session" do
			expect(post :create).to redirect_to "/"

		end

	end
end