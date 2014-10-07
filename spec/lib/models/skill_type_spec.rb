require 'rails_helper'

describe SkillType do

  context '#type' do

    let(:skill_type) {SkillType.new}

    it 'should create a list of tech skills, and a list of consulting skills' do
      expect(skill_type.tech_skills).to_not be_empty
      expect(skill_type.consulting_skills).to_not be_empty
    end

    it 'should return whether a skill is of type tech or consulting' do
      expect(skill_type.type_of('java')).to eq('tech')
      expect(skill_type.type_of('problem solving')).to eq('consulting')
    end

  end
end