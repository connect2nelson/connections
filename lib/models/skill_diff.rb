class SkillDiff
  attr_reader :name

  def initialize(name, consultant_one, consultant_two)
    @name = name
    @consultant_one = consultant_one
    @consultant_two = consultant_two
  end

  def consultant_one_level
    @consultant_one.skills[@name]
  end

  def consultant_two_level
    @consultant_two.skills[@name]
  end

  def total
    consultant_one_level.to_i + consultant_two_level.to_i
  end

  def <=>(other)
    other.total <=> total
  end

end
