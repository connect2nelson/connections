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

    it 'should return all sf consultants' do
        Consultant.create({full_name: 'Adam', working_office: 'San Francisco'})
        Consultant.create({full_name: 'Billy', working_office: 'San Francisco'})
        Consultant.create({full_name: 'Charlotte', working_office: 'New York'})
        Consultant.create({full_name: 'Denise', working_office: 'Chicago'})
        expect(ConnectionService.all_sf_consultants.size).to eq 2
    end
  end

  context '.best_mentors_for' do

    let!(:java_and_ruby_master) {Consultant.create(full_name: 'Charlotte', skills: {"java" => "5", "ruby" => "5" }, working_office: "San Francisco") }
    let!(:ruby_master) {Consultant.create(full_name: 'Billy', skills: {"ruby" => "5" }, working_office: "San Francisco") }
    let!(:mentee) {Consultant.create(full_name: 'Adam', skills: {"java" => "1", "ruby"=> "1" }, working_office: "San Francisco") }
    let!(:chicago_ruby_master) {Consultant.create(full_name: 'Billy', skills: {"ruby" => "5" }, working_office: "Chicago") }

    it 'should return a list of matches for the mentee' do
      connections = ConnectionService.best_mentors_for mentee
      expect(connections.size).to eq 2
      expect(connections[0].mentor.full_name).to eq 'Charlotte'
    end

  end

  context '.best_mentees_for' do

    let!(:java_and_ruby_master) {Consultant.create(full_name: 'Charlotte', skills: {"java" => "5", "ruby" => "5" }, working_office: "San Francisco") }
    let!(:ruby_kid) {Consultant.create(full_name: 'Billy', skills: {"ruby" => "1" }, working_office: "San Francisco") }
    let!(:java_and_ruby_kid) {Consultant.create(full_name: 'Adam', skills: {"java" => "1", "ruby"=> "1" }, working_office: "San Francisco") }
    let!(:chicago_ruby_beginner) {Consultant.create(full_name: 'Billy', skills: {"ruby" => "2" }, working_office: "Chicago") }

    it 'should return a list of matches for the mentee' do
      connections = ConnectionService.best_mentees_for java_and_ruby_master
      expect(connections.size).to eq 2
      expect(connections[0].mentee.full_name).to eq 'Adam'
    end

  end

  context '.best_peers_for' do

    let!(:clojure_fanboy) {Consultant.create(full_name: 'Clojure Fanatics', skills: {'clojure' => '4', 'ruby' => '1'}, working_office: 'San Francisco')}
    let!(:ruby_fanboy) {Consultant.create(full_name: 'Male Rubyist', skills: {'clojure' => '1', 'ruby' => '4'}, working_office: 'San Francisco')}
    let!(:ruby_fangirl) {Consultant.create(full_name: 'Female Rubyist', skills: {'ruby' => '3', 'clojure' => '1'}, working_office: 'San Francisco')}
    let!(:neither_ruby_or_clojure) {Consultant.create(full_name: 'Neither', skills: {'java' => '5'}, working_office: 'San Francisco')}
    let!(:random_folk_in_chicago) {Consultant.create(full_name: 'Chicago Proud', skills: {'ruby' => '2', 'clojure' => '5'}, working_office: 'Chicago')}

    it 'should return a list of peer matches for the consultant in descending order' do
      connections = ConnectionService.best_peers_for ruby_fangirl
      expect(connections.size).to eq 3
      expect(connections[0].mentee.full_name).to eq 'Male Rubyist'
      expect(connections[1].mentee.full_name).to eq 'Clojure Fanatics'
      expect(connections[2].mentee.full_name).to eq 'Neither'
    end

  end

end
