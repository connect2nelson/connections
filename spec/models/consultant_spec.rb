require 'rails_helper'

RSpec.describe Consultant, :type => :model do

  describe 'attributes' do
    it { should have_fields(:full_name, :skills, :working_office) }
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
end
