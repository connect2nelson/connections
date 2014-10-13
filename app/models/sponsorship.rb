class Sponsorship
  include Mongoid::Document

  field :sponsor_id, type: String
  field :sponsee_id, type: String

end