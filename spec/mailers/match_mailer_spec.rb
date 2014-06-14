require "rails_helper"

RSpec.describe MatchMailer, :type => :mailer do
  let(:mentor) { 'mentor@thoughtworks.com' }
  let(:thoughtworker) { 'thoughtworker@thoughtworks.com' }
  before {
    mailer = MatchMailer.create_match_message(thoughtworker, mentor).deliver
    @consultant = Consultant.new(employee_id: "15230",
                                 full_name: "Pam Ocampo",
                                 working_office: "San Francisco")
    @connections = nil
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

  it 'assign a consultant employee email to the mailer' do
      connections_mailer = MatchMailer.send_connections(@consultant, @connections).deliver
      expect(connections_mailer.to).to include "#{@consultant.employee_id}@thoughtworks.com"
  end
end
