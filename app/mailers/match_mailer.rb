class MatchMailer < ActionMailer::Base
  default from: "no-reply@thoughtworks.com"
  default subject: '[Connections] New connection for you!'
  default date: Time.now

  def create_match_message(from, to, time)
    mail(to: [to, from])
  end
end
