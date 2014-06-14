class Consultant
  include Mongoid::Document
  field :full_name, type: String
  field :skills, type: Hash
end
