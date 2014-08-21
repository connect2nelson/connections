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
      expect(Office.new(consultants).skill_groups).to eq('Ruby' => consultants, 'Java' => consultants)
    end
  end


end

