class Office
  attr_reader :consultants

  def initialize(consultants)
    @consultants = consultants
  end

  def top_skills
    Skillset.new(consultants).top_skill_names
  end

end

