class Skillset
  attr_reader :consultants

  def initialize(consultants)
    @consultants = consultants
  end

  def skill_groups
    top_skill_names.inject({}) {|sum, skill_name| sum.merge(group_for(skill_name))}
  end

  def top_skill_names
    top_skills.sort_by {|k, v| v}.reverse.map(&:first)
  end

  def top_skills
    consultants.inject({}) do |sum, consultant|
      sum.merge(skills_for(consultant, sum))
    end
  end

  private

  def skills_for(consultant, aggregate={})
    consultant.skills.inject(aggregate) {|sum, (k, v)| sum.merge(k => sum[k].to_i + v.to_i) }
  end

  def group_for skill_name
    {skill_name => consultants.select { |consultant| consultant.has_skill?(skill_name) }}
  end
end
