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
    let!(:another_sponsee) {Consultant.create(full_name: 'Ian', employee_id: "2") }
    let!(:sponsorships) {[Sponsorship.create(sponsor_id: sponsor.employee_id, sponsee_id: sponsee.employee_id),
                          Sponsorship.create(sponsor_id: sponsor.employee_id, sponsee_id: another_sponsee.employee_id)
                          ]}
    let!(:consultants) {[sponsor]}

    it 'should create nodes for each consultant involved in the sponsorship network' do
      network = SponsorshipService.get_network_for consultants

      expect(network.nil?).to eq(false)
      expect(network[:nodes].length).to eq(3)
      expect(network[:nodes][0]["employee_id"]).to eq("1")
    end

    it 'should create links between sponsors and sponsees' do
      network = SponsorshipService.get_network_for consultants

      pp network[:links]
      expect(network.nil?).to eq(false)
      expect(network[:links].length).to eq(2)
      expect(network[:links][0]["source"]).to eq(0)
      expect(network[:links][0]["target"]).to eq(1)
    end

  end

end
