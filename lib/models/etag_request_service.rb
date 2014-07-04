class EtagRequestService

  def self.create(url)
    etag = ApiCallService.etag_from url
    response = EtagRequest.new(url, etag).response
    ApiCallService.save url, response.headers[:etag]
    JSON.parse(response.body)
  rescue => e
    return []
  end

end
