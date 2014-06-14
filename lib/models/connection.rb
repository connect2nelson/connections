class Connection
  attr_reader :mentor
  attr_reader :mentee

  def initialize(mentor, mentee)
    @mentor = mentor
    @mentee = mentee
  end

  def match?
  	mentor.skills.any? { |skill, level| mentee.skills[skill] == 1 && level == 5 } && 	mentor.working_office == mentee.working_office 
  end

end
