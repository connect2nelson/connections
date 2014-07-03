class GithubClient

  def initialize
    @base_url = "https://api.github.com"
    @credentials = "?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}"
  end

  def events_for_user user_name
    events(user_name).inject([]) { |all, e| all << create_event(e) if allowed_type?(e); all }
  end

  private

  def allowed_type? event
    event['type'] == "PushEvent"
  end

  def create_event event
    { event_id: event['id'],
      type: event['type'],
      repo_name: event['repo']['name'],
      languages: languages("#{event['repo']['url']}/languages"),
      created_at: event['created_at'],
      avatar: event['actor']['avatar_url']}
  end

  def events user_name
    begin
      events_request = request @base_url + "/users/#{user_name}/events"
      response = events_request.get
    rescue => e
      return []
    end
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

  def request path
    RestClient::Resource.new path + @credentials
  end

end
