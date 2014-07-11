class GithubEvent
  include Mongoid::Document

  field :employee_id, type: String
  field :avatar, type: String
  field :event_id, type: String
  field :type, type: String
  field :created_at, type: String
  belongs_to :github_repository

  index({event_id: 1}, {unique: true})

end
