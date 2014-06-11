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
end

