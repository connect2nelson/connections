class Contact
  include Mongoid::Document

  field :employee_id, type: String
  field :github_account, type: String

end
