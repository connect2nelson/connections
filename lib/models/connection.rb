class Connection
  attr_reader :mentor
  attr_reader :mentee

  def initialize(mentor, mentee)
    @mentor = mentor
    @mentee = mentee
  end

  def match?
  	mentor.skills.all? { |skill, level| mentee.skills[skill] != level } && 	mentor.working_office == mentee.working_office 
  end

end
