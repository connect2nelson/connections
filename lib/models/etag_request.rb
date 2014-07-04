class EtagRequest

  def initialize(url, etag)
    @url = url
    @etag = etag
    @credentials = "?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}"
  end

  def response
    request(@url).get(:if_none_match => @etag)
  end

  private

  def request path
    RestClient::Resource.new path + @credentials
  end
end
