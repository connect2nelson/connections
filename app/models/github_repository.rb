class GithubRepository
  include Mongoid::Document

  field :repo_name, type: String
  field :languages, type: Hash
  has_many :github_events

  index({repo_name: 1}, {unique: true})
end
