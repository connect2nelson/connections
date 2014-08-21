require 'rails_helper'

describe Skillset do
  describe '.new' do
    it 'should have consultants' do
      consultants = [Consultant.new]
      expect(Skillset.new(consultants).consultants).to eq consultants
    end
  end

  describe '#top_skill_names' do
    def top_skill_names(consultants=[])
      Skillset.new(consultants).top_skill_names
    end

    it 'should return the name of top skills of two consultants, in ascending order' do
      skillset_one = {'Ruby' => '2', 'Javascript' => '3'}
      skillset_two = {'Ruby' => '2', 'Clojure' => '5'}
      consultants = [Consultant.new(skills: skillset_one), Consultant.new(skills: skillset_two)]
      expect(top_skill_names(consultants)).to eq(['Clojure', 'Ruby', 'Javascript'])
    end

  end

  describe '#skill_groups' do
    def skill_groups(consultants=[])
      Skillset.new(consultants).skill_groups
    end

    it 'should be empty when no consultants' do
      expect(skill_groups).to be_empty
    end

    it 'should return consultants of one skill' do
      consultant_one = Consultant.new(skills: {'Ruby' => '5'})
      consultant_two = Consultant.new(skills: {'Ruby' => '5'})
      consultants = [consultant_one, consultant_two]
      expect(skill_groups(consultants)).to eq('Ruby' => consultants)
    end

    it 'should exclude consultants not having a skill' do
      consultant_one = Consultant.new(skills: {'Ruby' => '5'})
      consultant_two = Consultant.new(skills: {})
      consultants = [consultant_one, consultant_two]
      expect(skill_groups(consultants)).to eq('Ruby' => [consultant_one])
    end

    it 'should return consultant in multiple skill groups' do
      consultant_one = Consultant.new(skills: {'Ruby' => '5', 'Java' => '5'})
      consultants = [consultant_one]
      expect(skill_groups(consultants)).to eq('Ruby' => consultants, 'Java' => consultants)
    end

    it 'should only return expert consultants' do
      consultant_one = Consultant.new(skills: {'Ruby' => '3', 'Java' => '5'})
      consultant_two = Consultant.new(skills: {'Ruby' => '5', 'Java' => '2'})
      consultants = [consultant_one, consultant_two]
      expect(skill_groups(consultants)).to eq('Ruby' => [consultant_two], 'Java' => [consultant_one])
    end

    it 'should not return skill groups with no expert consultants' do
      consultant_one = Consultant.new(skills: {'Ruby' => '3', 'Java' => '5'})
      consultants = [consultant_one]
      expect(skill_groups(consultants)).to eq('Java' => [consultant_one])
    end

  end

  describe '#top_skills' do
    def top_skills(consultants=[])
      Skillset.new(consultants).top_skills
    end

    it 'should be empty when no consultants' do
      expect(top_skills).to be_empty
    end

    it 'should return skills of one consultant' do
      consultants = [Consultant.new(skills: {'Ruby' => '3', 'Javascript' => '5'})]
      expect(top_skills(consultants)).to eq('Ruby' => 3, 'Javascript' => 5)
    end

    it 'should return sum of two consultants' do
      skillset_one = {'Ruby' => '3', 'Javascript' => '5'}
      skillset_two = {'Java' => '4'}
      consultants = [Consultant.new(skills: skillset_one), Consultant.new(skills: skillset_two)]
      expect(top_skills(consultants)).to eq('Ruby' => 3, 'Javascript' => 5, 'Java' => 4)
    end

    it 'should return sum of three consultants' do
      skillset_one = {'Ruby' => '3', 'Javascript' => '5'}
      skillset_two = {'Java' => '4'}
      skillset_three = {'Story Writing' => '4'}
      consultants = [Consultant.new(skills: skillset_one), Consultant.new(skills: skillset_two), Consultant.new(skills: skillset_three)]
      expect(top_skills(consultants)).to eq('Ruby' => 3, 'Javascript' => 5, 'Java' => 4, 'Story Writing' => 4)
    end

    it 'should return aggregated skills of two consultants' do
      skillset_one = {'Ruby' => '3', 'Javascript' => '5'}
      skillset_two = {'Ruby' => '4', 'Clojure' => '2'}
      consultants = [Consultant.new(skills: skillset_one), Consultant.new(skills: skillset_two)]
      expect(top_skills(consultants)).to eq('Ruby' => 7, 'Javascript' => 5, 'Clojure' => 2)
    end


  end
end
