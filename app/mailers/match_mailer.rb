class MatchMailer < ActionMailer::Base
  default from: "no-reply@thoughtworks.com"
  default subject: '[Connections] New connection for you!'

  def create_match_message(from, to)
    mail(to: [to, from])
  end
end
