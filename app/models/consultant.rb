class Consultant
  include Mongoid::Document

  field :employee_id, type: String
  field :full_name, type: String
  field :skills, type: Hash
  field :working_office, type: String

  def skills_to_learn
    skills.select { |skill, value| value=="1"}.keys
  end

end
