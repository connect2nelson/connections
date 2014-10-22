class SkillTypeGrouping
	attr_reader :skill_type, :group, :skill_name
	def initialize(skill_type, group, skill_name)
	   @skill_type = skill_type
       @group = group
       @skill_name = skill_name
	end

	def empty?
       @skill_type == "" || @group.empty?
	end
end