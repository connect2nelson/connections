class EtagRequest

  def initialize(url, etag)
    @url = url
    @etag = etag
    @credentials = "?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}"
  end

  def response
    HTTParty.get(@url + @credentials)
  end

end
