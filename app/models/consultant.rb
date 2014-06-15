class Consultant
  include Mongoid::Document

  field :employee_id, type: String
  field :full_name, type: String
  field :working_office, type: String
  field :home_office, type: String
  field :primary_role, type: String
  field :skills, type: Hash

  def skills_to_learn
    skills.select { |skill, value| value=="1"}.keys
  end

end
