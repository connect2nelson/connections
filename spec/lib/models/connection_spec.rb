require 'rails_helper'

describe Connection do
  context '.new' do
    let(:mentor) {Consultant.new}
    let(:mentee) {Consultant.new}
    let(:connection) {Connection.new(mentor, mentee)}

    it 'should assign mentor' do
      expect(connection.mentor).to eq mentor
    end

    it 'should assign mentee' do
      expect(connection.mentee).to eq mentee
    end

  end

  context 'match' do
    let(:mentor) {Consultant.new(skills: {:ruby => 5 }) }
    let(:mentee) {Consultant.new(skills: {:ruby => 1 }) }
    let(:connection) {Connection.new(mentor, mentee)}

    it 'should be a match' do
      expect(connection).to be_match
    end
  end
end

