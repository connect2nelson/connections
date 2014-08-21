require 'rails_helper'

RSpec.describe Consultant, :type => :model do

  describe 'attributes' do
    it { expect(subject).to have_fields(:full_name, :skills, :working_office, :home_office, :primary_role) }
    let(:consultant) {Consultant.create(employee_id: 10001)}

    it 'should contain employee id in email' do
        expect(consultant.email).to include 'thoughtworks.com'
        expect(consultant.email).to include consultant.employee_id
    end
  end

  describe "#has_skill?" do
    subject { Consultant.new(skills: {'Java' => 4}) }
    it 'should have skill for java' do
      expect(subject).to have_skill('Java')
    end
    it 'should not have skill for ruby' do
      expect(subject).to_not have_skill('Ruby')
    end

  end

  describe '#skills_to_learn' do
    before { Consultant.create(full_name: 'Ian Norris', skills: Hash['Ruby'=>'1', 'Java'=>'2', 'Cat'=>'5'])}
    subject {Consultant.first}

    it 'should return skills with value 1' do
      skills = subject.skills_to_learn
      expect(skills.size).to eq 1
      expect(skills.first).to eq 'Ruby'
    end

  end

  describe '#skills_to_teach' do
    before { Consultant.create(full_name: 'Ian Norris', skills: Hash['Ruby'=>'1', 'Java'=>'2', 'Cat'=>'5'])}
    subject {Consultant.first}

    it 'should return skills with value 5' do
      skills = subject.skills_to_teach
      expect(skills.size).to eq 1
      expect(skills.first).to eq 'Cat'
    end

  end

  describe '#has_skills_from_jigsaw?' do
    before do
      Consultant.create(full_name: 'with data', skills: {'Ruby'=>'1'})
      Consultant.create(full_name: 'no data', skills: {})
    end

    it 'should return true if the consultant has jigsaw data' do
      expect(Consultant.find_by(full_name: 'with data').has_skills_from_jigsaw?).to be true
    end

    it 'should return false if the consultant has no jigsaw data' do
      expect(Consultant.find_by(full_name: 'no data').has_skills_from_jigsaw?).to be false
    end
  end

  describe '#expert_in?' do

    it 'should return true if the consultant has 5 in one skill' do
      consultant = Consultant.new(skills: {'Ruby'=>'5'})
      expect(consultant).to be_expert_in 'Ruby'
    end

    (1..4).each do |i|
      it "should return false if the consultant skill level is #{i}" do
        consultant = Consultant.new(skills: {'Ruby'=>i.to_s})
        expect(consultant).to_not be_expert_in 'Ruby'
      end
    end

    it 'should return false if the consultant has no skills' do
      consultant = Consultant.new(skills: {})
      expect(consultant).to_not be_expert_in 'Ruby'
    end

  end

end
