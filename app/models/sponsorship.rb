class Sponsorship
  include Mongoid::Document

  field :sponsor_id, type: String
  field :sponsee_id, type: String

  index({ sponsor_id: 1, sponsee_id: 1 }, { unique: true })
end