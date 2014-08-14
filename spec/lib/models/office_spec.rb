require 'rails_helper'

describe Office do

  context '.new' do
    it 'should have consultants' do
      consultants = [Consultant.new]
      expect(Office.new(consultants).consultants).to eq consultants
    end
  end

  context '#top_skills' do
    def top_skills(consultants=[])
      Office.new(consultants).top_skills
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

