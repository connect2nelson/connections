class MatchMailer < ActionMailer::Base
  default from: "no-reply@thoughtworks.com"
  default subject: '[Connections] New connection for you!'

  def create_match_message(from, to)
      mail(to: [to, from])
  end

  def send_connections(consultant, connections)
      @consultant = consultant
      @connections = connections
      @consultant_email = "#{consultant.employee_id}@thoughtworks.com"
      mail(to: @consultant_email)
  end
end
