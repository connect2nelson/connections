class Skillset
  attr_reader :consultants

  def initialize(consultants)
    @consultants = consultants
    @skill_type = SkillType.new()
  end

  def skill_groups
    sum = {}
    unordered_skill_names.map{ |skill_name|
      group = group_for_name skill_name
      skill_type = @skill_type.type_of(skill_name.downcase)
      SkillTypeGrouping.new(skill_type, group, skill_name)
    }.reject{|skill| skill.empty?}
    .reduce({}) {|groupings, skill|
      if not groupings[skill.skill_type]
        groupings[skill.skill_type] = {}
      end
      groupings[skill.skill_type][skill.skill_name]=skill.group
      groupings
    }
  end

  def top_skill_names
    top_skills.sort_by {|k, v| v}.reverse.map(&:first)
  end

  def unordered_skill_names
    Set.new consultants.map{|consultant| consultant.skills.keys}.reduce(:+)
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

  def group_for_name skill_name
    consultants.select { |consultant| consultant.expert_in?(skill_name) }
  end

  def group_for skill_name
    {skill_name => consultants.select { |consultant| consultant.expert_in?(skill_name) }}
  end
end
