class ApiCallService

  def self.etag_from url
    api_call = ApiCall.where(url: url).first
    api_call[:etag] if api_call
  end

  def self.save url, etag
    existingApiCall = ApiCall.where(url: url).first
    if existingApiCall
      existingApiCall.update_attributes(etag: etag)
    else
      ApiCall.create(:url => url, :etag => etag)
    end
  end

end
