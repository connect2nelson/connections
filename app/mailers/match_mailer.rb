class MatchMailer < ActionMailer::Base
  default from: "no-reply@thoughtworks.com"
  default subject: '[Connections] New connection for you!'

  def create_match_message(from, to)
      mail(to: [to, from])
  end

  def send_connections(consultant, connections)
      @consultant = consultant
      @connections = connections
      mail(to: "#{consultant.employee_id}@thoughtworks.com")
  end
end
