class Connection
  attr_reader :mentor
  attr_reader :mentee

  def initialize(mentor, mentee)
    @mentor = mentor
    @mentee = mentee
  end

  def match?
    true
  end

end
