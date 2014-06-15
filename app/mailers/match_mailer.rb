class MatchMailer < ActionMailer::Base
  default from: "no-reply@thoughtworks.com"
  default subject: '[Connections] New connection for you!'

  def send_connections(consultant, connections)
      @consultant = consultant
      @connections = connections
      mail(to: consultant.email)
  end
end
