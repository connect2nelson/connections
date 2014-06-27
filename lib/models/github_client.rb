class GithubClient

  def initialize
    @key = ENV['GITHUB_KEY']
    @secret = ENV['GITHUB_SECRET']
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
      created_at: event['created_at']}
  end

  def events user_name
    begin
      response = RestClient.get("https://api.github.com/users/#{user_name}/events?client_id=#{@key}&client_secret=#{@secret}")
    rescue => e
      return []
    end
    JSON.parse(response.body)
  end

  def languages languages_url
    begin
      response = RestClient.get(languages_url + "?client_id=#{@key}&client_secret=#{@secret}")
    rescue => e
      return {}
    end
    JSON.parse(response.body)
  end

end
