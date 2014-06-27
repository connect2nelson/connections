class MatchMailer < ActionMailer::Base
  default from: "connections@thoughtworks.com"
  default subject: '[Connections] Say hey to these ThoughtWorkers!'

  def send_connections(consultant, connections)
      @consultant = consultant
      @mentors = connections[:mentors]
      @mentees = connections[:mentees]
      mail(to: consultant.email)
  end
end
