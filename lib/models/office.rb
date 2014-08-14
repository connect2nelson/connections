class Office
  attr_reader :consultants

  def initialize(consultants)
    @consultants = consultants
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
end
