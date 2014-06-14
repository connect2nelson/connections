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
    let(:mentor) {Consultant.new(skills: {"ruby" => 5 }, working_office: "office") }
    let(:mentee) {Consultant.new(skills: {"ruby"=> 1 }, working_office: "office") }
    let(:sf_mentee) {Consultant.new(skills: {"ruby" => 1 }, working_office: "San Francisco") }
    let(:chicago_mentor) {Consultant.new(skills: {"ruby" => 5 }, working_office: "Chicago") }
    let(:ruby_chicago_master) {Consultant.new(skills: {"ruby" => 5 }, working_office: "Chicago") }
    let(:java_master) {Consultant.new(skills: {"java" => 5, "ruby" => 5 }, working_office: "San Francisco") }
    let(:java_maestro) {Consultant.new(skills: {"java" => 5, "ruby" => 1 }, working_office: "San Francisco") }



    let(:connection) {Connection.new(mentor, mentee)}
    let(:connection_between_chicago_and_sf) {Connection.new(chicago_mentor, sf_mentee)}
    let(:connection_between_two_chicago_masters) {Connection.new(chicago_mentor, ruby_chicago_master)}
    let(:connection_between_java_masters) {Connection.new(java_maestro, java_master)}



    it 'should be a match' do
      expect(connection).to be_match
    end

    it 'should not match if in different working offices' do
      expect(connection_between_chicago_and_sf).to_not be_match
    end

    it 'should not match if two ruby experts' do
        expect(connection_between_two_chicago_masters).to_not be_match
    end

    it "should not match two java experts" do 
      expect(connection_between_java_masters).to_not be_match
    end




  end


end

