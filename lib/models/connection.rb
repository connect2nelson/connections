class Connection
  attr_reader :mentor
  attr_reader :mentee

  def initialize(mentor, mentee)
    @mentor = mentor
    @mentee = mentee
  end

  def match?
  	mentor.working_office == mentee.working_office && mentor.skills["ruby"] != mentee.skills["ruby"]
  end

end
