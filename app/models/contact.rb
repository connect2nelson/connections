class Contact
  include Mongoid::Document

  field :employee_id, type: String
  field :github_account, type: String

  index({ employee_id: 1 }, { unique: true })
  index({ github_account: 1 }, { unique: true })
end
