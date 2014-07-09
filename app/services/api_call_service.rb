class ApiCallService

  def self.etag_from url
    ApiCall.where(url: url).pluck(:etag).first
  end

  def self.save url, etag
    ApiCall.where(url: url).first_or_initialize.update_attributes(url: url, etag: etag)
  end

end
