require 'rails_helper'

describe SponsorshipService do

  context '.get_sponsees_for' do

    let!(:consultant) {Consultant.create(full_name: 'Charlotte', employee_id: "1") }
    let!(:no_sponsees) {Consultant.create(full_name: 'Sophie', employee_id: "3") }
    let!(:sponsee) {Consultant.create(full_name: 'Billy', employee_id: "2") }
    let!(:sponsorships) {[Sponsorship.create(sponsor_id: consultant.employee_id, sponsee_id: sponsee.employee_id)]}

    it 'should return an empty list if the consultant doesnt have any sponsees' do
      expect(Sponsorship).to receive(:all).with({:sponsor_id=>consultant.employee_id}).and_return []
      sponsees = SponsorshipService.get_sponsees_for consultant

      expect(sponsees.size).to eq 0
    end

    it 'should return a list of current sponsees for the consultant' do
      expect(Sponsorship).to receive(:all).with({:sponsor_id=>consultant.employee_id}).and_return sponsorships
      expect(Consultant).to receive(:find_by).with({:employee_id=>sponsee.employee_id}).and_return sponsee
      sponsees = SponsorshipService.get_sponsees_for consultant

      expect(sponsees.size).to eq 1
      expect(sponsees[0].mentee.full_name).to eq sponsee.full_name
    end

  end

  context '.get_network_json_for' do

    let!(:sponsor) {Consultant.create(full_name: 'Derek', employee_id: "1") }
    let!(:sponsee) {Consultant.create(full_name: 'Sophie', employee_id: "3") }

    it 'should create a node for a sponsee not in the office consultant list' do
      office_consultants = [sponsor]
      sponsorships = [Sponsorship.create(sponsor_id: sponsor.employee_id, sponsee_id: sponsee.employee_id)]

      network = SponsorshipService.get_network_for office_consultants

      expect(network.nil?).to eq(false)
      expect(network[:nodes].length).to eq(2)
      expect(network[:nodes][0]["full_name"]).to eq(sponsor.full_name)
      expect(network[:nodes][1]["full_name"]).to eq(sponsee.full_name)
    end

    it 'should create a node for a consultant without any sponsorships' do
      no_sponsorships = Consultant.create(full_name: 'Shane', employee_id: "4")
      office_consultants = [sponsor, no_sponsorships]
      sponsorships = [Sponsorship.create(sponsor_id: sponsor.employee_id, sponsee_id: sponsee.employee_id)]

      network = SponsorshipService.get_network_for office_consultants

      expect(network[:nodes].length).to eq(3)
      expect(network[:nodes][1]["full_name"]).to eq(no_sponsorships.full_name)
    end

    it 'should create links between all sponsors and sponsees' do
      office_consultants = [sponsor]
      another_sponsee = Consultant.create(full_name: 'Ian', employee_id: "2")
      sponsorships = [Sponsorship.create(sponsor_id: sponsor.employee_id, sponsee_id: sponsee.employee_id),
                      Sponsorship.create(sponsor_id: sponsor.employee_id, sponsee_id: another_sponsee.employee_id)]

      network = SponsorshipService.get_network_for office_consultants

      expect(network[:links].length).to eq(2)
    end

    it 'should only create one link if sponsor and sponsee are both in the office consultants list' do
      office_consultants = [sponsor, sponsee]
      sponsorships = [Sponsorship.create(sponsor_id: sponsor.employee_id, sponsee_id: sponsee.employee_id)]
      network = SponsorshipService.get_network_for office_consultants

      expect(network[:links].length).to eq(1)
    end

  end

end
