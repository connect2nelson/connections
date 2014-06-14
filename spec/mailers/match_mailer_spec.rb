require "rails_helper"

RSpec.describe MatchMailer, :type => :mailer do
  let(:mentor) { 'mentor@thoughtworks.com' }
  let(:thoughtworker) { 'thoughtworker@thoughtworks.com' }
  before {
    MatchMailer.create_match_message(thoughtworker, mentor).deliver
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

  it 'should send email with sent date to today' do
      expect(subject.date.utc.to_i).to eq Time.now.utc.to_i
  end
end
