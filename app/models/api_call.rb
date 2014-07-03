class ApiCall
  include Mongoid::Document

  field :url, type: String
  field :etag, type: String

  index({url: 1}, {unique: true})

end
