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

  describe "get sponsees for office" do
    sponsorlessAC = Consultant.new(employee_id: "1")
    sponsorlessTechLead = Consultant.new(employee_id: "2")
    it "should get all the ACs and non ACs that are sponsorless for a given office" do
      allow(SponsorshipService).to receive(:get_sponsorless_individuals_for) {[sponsorlessTechLead]}
      allow(SponsorshipService).to receive(:get_sponsorless_ACs_for) {[sponsorlessAC]}
      get "sponsorless", :office => "San Francisco"
      expect(SponsorshipService).to have_received(:get_sponsorless_individuals_for).with("San Francisco")
      expect(SponsorshipService).to have_received(:get_sponsorless_ACs_for).with("San Francisco")
      expect(assigns(:sponsorless)).to include(sponsorlessTechLead)
      expect(assigns(:coachless)).to include(sponsorlessAC)
    end
  end
end

