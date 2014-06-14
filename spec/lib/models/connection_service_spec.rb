require 'rails_helper'

describe ConnectionService do
  context '.all' do
    it 'should return zero connections between zero people' do
      expect(ConnectionService.all.size).to eq 0
    end
    it 'should return two connections between two people' do
      Consultant.create({full_name: 'Adam'})
      Consultant.create({full_name: 'Billy'})
      expect(ConnectionService.all.size).to eq 2
    end
    it 'should return six connections between three people' do
      Consultant.create({full_name: 'Adam'})
      Consultant.create({full_name: 'Billy'})
      Consultant.create({full_name: 'Charlotte'})
      expect(ConnectionService.all.size).to eq 6
    end

    context "sorting" do

      let!(:java_and_ruby_master) {Consultant.create(full_name: 'Charlotte', skills: {"java" => "5", "ruby" => "5" }, working_office: "San Francisco") }
      let!(:ruby_master) {Consultant.create(full_name: 'Billy', skills: {"ruby" => "5" }, working_office: "San Francisco") }
      let!(:mentee) {Consultant.create(full_name: 'Adam', skills: {"java" => "1", "ruby"=> "1" }, working_office: "San Francisco") }

      it 'should sort connections by greatest gap in skills' do
        connections = ConnectionService.all
        connections_for_mentee = connections.select{|connection| connection.mentee.full_name == 'Adam' }
        first_connection_mentor = connections_for_mentee[0].mentor
        first_connection_mentor_skills = connections_for_mentee[0].relevant_skills

        expect(connections.size).to eq 6
        expect(connections_for_mentee[0].skill_gap).to eq 8
        expect(first_connection_mentor.full_name).to eq "Charlotte"
      end

      it 'should tell me which skills were a match' do
        connections = ConnectionService.all
        connections_for_mentee = connections.select{|connection| connection.mentee.full_name == 'Adam' }
        first_connection_mentor_skills = connections_for_mentee[0].relevant_skills

        expect(first_connection_mentor_skills.length).to eq 2
        expect(first_connection_mentor_skills["ruby"]).to eq 4
      end

    end
    
  end

  context '.sf_office' do
    it 'should return zero connections between zero people' do
      expect(ConnectionService.sf_office.size).to eq 0
    end
    it 'should return two connections between two people' do
      Consultant.create({full_name: 'Adam', working_office: 'San Francisco'})
      Consultant.create({full_name: 'Billy', working_office: 'San Francisco'})
      Consultant.create({full_name: 'Charlie', working_office: 'Chicago'})
      expect(ConnectionService.sf_office.size).to eq 2
    end
    it 'should return six connections between three people' do
      Consultant.create({full_name: 'Adam', working_office: 'San Francisco'})
      Consultant.create({full_name: 'Billy', working_office: 'San Francisco'})
      Consultant.create({full_name: 'Charlotte', working_office: 'San Francisco'})
      Consultant.create({full_name: 'Denise', working_office: 'Chicago'})
      expect(ConnectionService.sf_office.size).to eq 6
    end
  end

  context '.best_match_for' do

    let!(:java_and_ruby_master) {Consultant.create(full_name: 'Charlotte', skills: {"java" => "5", "ruby" => "5" }, working_office: "San Francisco") }
    let!(:ruby_master) {Consultant.create(full_name: 'Billy', skills: {"ruby" => "5" }, working_office: "San Francisco") }
    let!(:mentee) {Consultant.create(full_name: 'Adam', skills: {"java" => "1", "ruby"=> "1" }, working_office: "San Francisco") }

    it 'should return a list of matches for the mentee' do
      connections = ConnectionService.best_match_for mentee
      expect(connections.size).to eq 2
      expect(connections[0].mentor.full_name).to eq 'Charlotte'
    end

  end

end
