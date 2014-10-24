require 'rails_helper'

describe Office do

  describe '.new' do
    let(:consultants) {[Consultant.new(home_office: 'San Francisco')]}
    it 'should have consultants' do
      expect(Office.new(consultants).consultants).to eq consultants
    end
  end

  describe '#name' do
    it 'should return office name' do
      consultants = [Consultant.new(home_office: 'San Francisco')]
      expect(Office.new(consultants).name).to eq 'San Francisco'
    end
  end

  describe '#top_skills' do
    it 'should return aggregated skills of two consultants' do
      skillset_one = {'Ruby' => '3', 'Javascript' => '5'}
      skillset_two = {'Ruby' => '4', 'Clojure' => '2'}
      consultants = [Consultant.new(skills: skillset_one), Consultant.new(skills: skillset_two)]
      expect(Office.new(consultants).top_skills).to eq(['Ruby', 'Javascript', 'Clojure'])
    end
  end

  describe '#skill_groups' do
    it 'should consultants in multiple skill groups' do
      consultant_one = Consultant.new(skills: {'Ruby' => '5', 'Java' => '5'})
      consultants = [consultant_one]
      expect(Office.new(consultants).skill_groups).to eq('tech' => {'Ruby' => consultants, 'Java' => consultants})
    end
  end

  describe '#git_repo_groups' do
    it 'should return the git repos for the office with contributors' do

      repo = GithubRepository.create(:repo_name => "grezha")

      consultant = Consultant.new(:employee_id => "1")
      another_consultant = Consultant.new(:employee_id => "2")
      consultants = [consultant, another_consultant]

      GithubEvent.create(:employee_id => consultant.employee_id, :github_repository_id => repo.id)
      GithubEvent.create(:employee_id => another_consultant.employee_id, :github_repository_id => repo.id)
      GithubEvent.create(:employee_id => another_consultant.employee_id, :github_repository_id => repo.id)

      repo_groups = Office.new(consultants).git_repo_groups
      expect(repo_groups[0].consultants).to eq([another_consultant, consultant])
    end

  end

  describe '#sponsorship_network' do

    let!(:sponsor) {Consultant.create(full_name: 'Derek', employee_id: "1")}
    let!(:sponsee) {Consultant.create(full_name: 'Sophie', employee_id: "3")}
    let!(:office_consultants) {[sponsor, sponsee]}

    it 'should create a network of sponsorships from the office consultant list' do
      Sponsorship.create(sponsor_id: sponsor.employee_id, sponsee_id: sponsee.employee_id)

      network = Office.new(office_consultants).sponsorship_network

      expect(network.nil?).to eq(false)
      expect(network[:nodes].length).to eq(2)
      expect(network[:nodes][0]["full_name"]).to eq(sponsor.full_name)
      expect(network[:nodes][1]["full_name"]).to eq(sponsee.full_name)
    end
  end

end

