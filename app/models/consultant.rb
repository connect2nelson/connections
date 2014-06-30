class Consultant
  include Mongoid::Document

  EXPERT_SKILL = "5"
  WANTS_TO_LEARN_SKILL = "1"

  attr_accessor(:email)

  field :employee_id, type: String
  field :full_name, type: String
  field :working_office, type: String
  field :home_office, type: String
  field :primary_role, type: String
  field :skills, type: Hash

  def email
      self.email = "#{self.employee_id}@thoughtworks.com"
  end

  def skills_to_learn
    skills.select { |skill, value| value == WANTS_TO_LEARN_SKILL }.keys
  end

  def skills_to_teach
    skills.select { |skill, value| value == EXPERT_SKILL }.keys
  end

  def has_skills_from_jigsaw?
    !skills.empty?
  end
end
