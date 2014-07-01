class GithubEvent
  include Mongoid::Document

  field :employee_id, type: String
  field :avatar, type: String
  field :event_id, type: String
  field :type, type: String
  field :repo_name, type: String
  field :languages, type: Hash
  field :created_at, type: String

  index({event_id: 1}, {unique: true})

end
