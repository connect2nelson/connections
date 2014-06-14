class Connection
  attr_reader :mentor
  attr_reader :mentee

  def initialize(mentor, mentee)
    @mentor = mentor
    @mentee = mentee
    skill_gap =0
  end

  def match?
    has_skill_to_learn? && same_working_office?
  end

  def same_working_office?
    mentor.working_office == mentee.working_office 
  end

  def has_skill_to_learn?
    mentor.skills.any? { |skill, level| can_learn_from?(skill, level)} 
  end

  def can_learn_from?(skill, level)
    mentee.skills[skill].to_i == 1 && level.to_i == 5
  end

  def skill_gap
    mentor.skills.inject(0) do |sum, (skill, level)|
      sum += level.to_i - mentee.skills[skill].to_i
    end
  end
end
