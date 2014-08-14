require 'rails_helper'

describe Office do

  describe '.new' do
    it 'should have consultants' do
      consultants = [Consultant.new]
      expect(Office.new(consultants).consultants).to eq consultants
    end
  end

  describe '#top_skills' do
    def top_skills(consultants=[])
      Office.new(consultants).top_skills
    end

    it 'should return aggregated skills of two consultants' do
      skillset_one = {'Ruby' => '3', 'Javascript' => '5'}
      skillset_two = {'Ruby' => '4', 'Clojure' => '2'}
      consultants = [Consultant.new(skills: skillset_one), Consultant.new(skills: skillset_two)]
      expect(top_skills(consultants)).to eq(['Ruby', 'Javascript', 'Clojure'])
    end
  end


end

