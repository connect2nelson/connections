require "rails_helper"

RSpec.describe MatchMailer, :type => :mailer do
  let(:mentor) { 'mentor@thoughtworks.com' }
  let(:thoughtworker) { 'thoughtworker@thoughtworks.com' }
  before {
    mailer = MatchMailer.create_match_message(thoughtworker, mentor).deliver
    @consultant = Consultant.new(employee_id: "15230",
                                 full_name: "Pam Ocampo",
                                 working_office: "San Francisco",
                                 skills: {"Ruby"=>"1", "Java"=>"1"})
    @mentor = Consultant.new(employee_id: "10001",
                             full_name: "Derek Hammer",
                             skills: {"Ruby"=>"5", "Java"=>"5"})
    @connections = [Connection.new(@mentor, @consultant)]
    @connections_mailer = MatchMailer.send_connections(@consultant, @connections).deliver
  }
  subject { ActionMailer::Base.deliveries.first }

  it 'should send an email' do
    expect(subject).to_not be_nil
  end
  it 'should send an email to a mentor' do
    expect(subject.to).to include mentor
  end
  it 'should send an email to a thoughtworker' do
    expect(subject.to).to include thoughtworker
  end
  it 'should send an email from noreply' do
    expect(subject.from).to include 'no-reply@thoughtworks.com'
  end

  it 'should send an email with subject [Connnections] New connection for you!' do
    expect(subject.subject).to eq '[Connections] New connection for you!'
  end

  it 'should assign a consultant employee email to the mailer' do
      expect(@connections_mailer.to).to include "#{@consultant.employee_id}@thoughtworks.com"
  end

  it 'should have a list of of connection mentors' do
      expect(@connections_mailer.body).to include @connections.first.mentor.full_name
  end

  it 'should have a connection mentors email' do
      expect(@connections_mailer.body).to include @connections.first.mentor.email
      expect(@connections.first.mentor.email).to eq "10001@thoughtworks.com"
  end

  it 'should have a list of of connection mentors' do
      expect(@connections_mailer.body).to include @connections.first.mentor.full_name
  end

  it 'should include the list of skills per mentor in the body' do
      expect(@connections_mailer.body).to include @connections.first.mentor.skills.keys[0]
      expect(@connections_mailer.body).to include @connections.first.mentor.skills.keys[1]
  end
end
