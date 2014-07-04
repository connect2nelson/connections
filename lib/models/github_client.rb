class GithubClient

  def initialize
    @base_url = "https://api.github.com"
    @credentials = "?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}"
  end

  def events_for_user user_name
    event_url = @base_url + "/users/#{user_name}/events"
    etag = ApiCallService.etag_from event_url
    events(event_url, etag).inject([]) { |all, e| all << create_event(e) if allowed_type?(e); all }
  end

  private

  def events event_url, etag
    begin
      events_request = request event_url
      response = events_request.get(:if_none_match => etag)
    rescue => e
      return []
    end
    ApiCallService.save event_url, response.headers[:etag]
    JSON.parse(response.body)
  end

  def languages languages_url
    begin
      languages_request = request languages_url
      response = languages_request.get
    rescue => e
      return {}
    end
    JSON.parse(response.body)
  end

  # don't want to save the old ones
  def create_event event
    { event_id: event['id'],
      type: event['type'],
      repo_name: event['repo']['name'],
      languages: languages("#{event['repo']['url']}/languages"),
      created_at: event['created_at'],
      avatar: event['actor']['avatar_url']}
  end

  def request path
    RestClient::Resource.new path + @credentials
  end

  def allowed_type? event
    event['type'] == "PushEvent"
  end

end
