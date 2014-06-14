class Connection
  attr_reader :mentor, :mentee, :skill_gap

  def initialize(mentor, mentee)
    @mentor = mentor
    @mentee = mentee
    @skill_gap = calculate_skill_gap
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

  def calculate_skill_gap
    return 0 if mentor.skills.nil?

    sum = 0
    mentor.skills.each do |skill, level|
      if mentee.skills.has_key?(skill)
        diff = level.to_i - mentee.skills[skill].to_i
        sum = sum + diff
      end
    end
    return sum

  end

end
