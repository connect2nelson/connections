require 'rails_helper'

RSpec.describe SponsorshipController, :type => :controller do

  describe 'create PUT' do

    it 'should create a new sponsorship' do
      consultant = Consultant.new(employee_id: "1")
      sponsee = Consultant.new(employee_id: "2")
      allow(SponsorshipService).to receive(:get_connection_for) {Connection.new(consultant, sponsee)}
      post :create, Hash[sponsor_id: consultant.employee_id, sponsee_id: sponsee.employee_id]
    end

  end

  describe "delete sponsee" do
    it "should delete the sponsor relationship with a given sponsee" do
      Sponsorship.create(sponsor_id: 2, sponsee_id: 3)
      expect(Sponsorship.count).to be(1)
      post :delete, Hash[sponsor_id: 2, sponsee_id: 3]
      expect(Sponsorship.count).to be(0)
    end
  end
end

