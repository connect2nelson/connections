
require "rails_helper"

RSpec.describe MatchMailer, :type => :mailer do
  it 'send an email to a mentor' do
    email = MatchMailer.create_match_message('cupid@thoughtworks.com', 'thoughtworker@thoughtworks.com', Time.now).deliver
    expect{ActionMailer::Base.deliveries}.empty be_false
  end
end
