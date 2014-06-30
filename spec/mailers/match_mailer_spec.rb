require "rails_helper"

RSpec.describe MatchMailer, :type => :mailer do
    before {
        @consultant = Consultant.new(employee_id: "15230",
                                     full_name: "Pam Ocampo",
                                     working_office: "San Francisco",
                                     skills: {"Ruby"=>"1", "Java"=>"1", "CSS" => "5", "Lifting" => "5"})
        @mentee = Consultant.new(employee_id: "mentee_match",
                                 full_name: "Peiying Wen",
                                 skills: {"CSS"=>"1", "Lifting"=>"1"})
        @mentor = Consultant.new(employee_id: "mentor_match",
                                 full_name: "Derek Hammer",
                                 skills: {"Ruby"=>"5", "Java"=>"5"})
        @mentee_matches = [Connection.new(@consultant, @mentee)]
        @mentor_matches = [Connection.new(@mentor, @consultant)]
        @connections = {:mentors => @mentor_matches, :mentees => @mentee_matches}
        @connections_mailer = MatchMailer.send_connections(@consultant, @connections)
    }

    subject { ActionMailer::Base.deliveries.first }

    it 'should send an email' do
        expect(@connections_mailer).to_not be_nil
    end

    it 'should send an email to a thoughtworker' do
        expect(@connections_mailer.to).to include @consultant.email
    end

    it 'should send an email from noreply' do
        expect(@connections_mailer.from).to include 'connections@thoughtworks.com'
    end

    it 'should send an email with subject [Connnections] Say hey to these ThoughtWorkers!' do
        expect(@connections_mailer.subject).to eq '[Connections] Say hey to these ThoughtWorkers!'
    end

    it 'should have a list of of connection mentors' do
        expect(@connections_mailer.body).to include @connections[:mentors].first.mentor.full_name
        expect(@connections_mailer.body).to include @connections[:mentees].first.mentee.full_name
    end

    it 'should have a connections email' do
        expect(@connections_mailer.body).to include @connections[:mentors].first.mentor.email
        expect(@connections[:mentors].first.mentor.email).to eq "mentor_match@thoughtworks.com"

        expect(@connections_mailer.body).to include @connections[:mentees].first.mentee.email
        expect(@connections[:mentees].first.mentee.email).to eq "mentee_match@thoughtworks.com"
    end

    it 'should have a list of of connections' do
        expect(@connections_mailer.body).to include @connections[:mentors].first.mentor.full_name
        expect(@connections_mailer.body).to include @connections[:mentees].first.mentee.full_name
    end

    it 'should include the list of skills per connection in the body' do
        expect(@connections_mailer.body).to include @connections[:mentors].first.mentor.skills.keys[0]
        expect(@connections_mailer.body).to include @connections[:mentors].first.mentor.skills.keys[1]

        expect(@connections_mailer.body).to include @connections[:mentees].first.mentee.skills.keys[0]
        expect(@connections_mailer.body).to include @connections[:mentees].first.mentee.skills.keys[1]
    end
    it 'should send a message about filling jigsaw when no skills are found' do
        @unskilled_consultant = Consultant.new(employee_id: "15230",
                                     full_name: "Pam Ocampo",
                                     working_office: "San Francisco",
                                     skills: {})
        @mentee_matches = [Connection.new(@unskilled_consultant, @mentee)]
        @mentor_matches = [Connection.new(@mentor, @consultant)]
        @connections = {:mentors => @mentor_matches, :mentees => @mentee_matches}
        @connections_mailer = MatchMailer.send_connections(@unskilled_consultant, @connections)
        expect(@connections_mailer.body).to include 'Fill out your skills'
    end
end
