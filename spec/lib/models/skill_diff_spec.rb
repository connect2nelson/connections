require 'rails_helper'

describe SkillDiff do

  context '.new' do
    let(:skill_diff) {SkillDiff.new('java', Consultant.new, Consultant.new)}

    it 'should assign skill' do
      expect(skill_diff.name).to eq 'java'
    end
  end

  context '#consultant_one_level' do
    let(:consultant_one) {Consultant.new(skills: {'java'=>'1'})}
    let(:skill_diff) {SkillDiff.new('java', consultant_one, Consultant.new)}

    it 'should return skill level of consultant one' do
      expect(skill_diff.consultant_one_level).to eq '1'
    end

  end

  context '#consultant_two_level' do
    let(:consultant_two) {Consultant.new(skills: {'java'=>'3'})}
    let(:skill_diff) {SkillDiff.new('java', Consultant.new, consultant_two)}

    it 'should return skill level of consultant two' do
      expect(skill_diff.consultant_two_level).to eq '3'
    end

  end
end
