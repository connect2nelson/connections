class EtagRequestService

  def self.create url
    etag = ApiCallService.etag_from url
    response = EtagRequest.new(url, etag).response
    ApiCallService.save url, response.headers[:etag]
    EtagResponse.new(response)
  rescue
    return EtagNullResponse.new
  end

end
