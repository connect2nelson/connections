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

  context '#total' do
    let(:consultant_two) {Consultant.new(skills: {'java'=>'3'})}
    let(:consultant_one) {Consultant.new(skills: {'java'=>'1'})}
    let(:skill_diff) {SkillDiff.new('java', consultant_one, consultant_two)}

    it 'should return skill level of consultant two' do
      expect(skill_diff.total).to eq 4
    end
  end

  context 'sorting' do
    let(:consultant_one) {Consultant.new(skills: {'java'=>'1'})}
    let(:consultant_two) {Consultant.new(skills: {'java'=>'3'})}
    let(:consultant_three) {Consultant.new(skills: {'java'=>'1'})}
    let(:skill_diff_one) {SkillDiff.new('java', consultant_one, consultant_two)}
    let(:skill_diff_two) {SkillDiff.new('java', consultant_three, consultant_one)}

    it 'should return skill level of consultant two' do
      expect([skill_diff_one, skill_diff_two].sort).to eq [skill_diff_one, skill_diff_two]
    end
  end
end
