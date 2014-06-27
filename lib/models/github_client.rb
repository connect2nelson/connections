class GithubClient

  def initialize
    @key = ENV['GITHUB_KEY']
    @secret = ENV['GITHUB_SECRET']
  end

  def events_for_user user_name
    events(user_name).map do |event|
      { event_id: event['id'],
        type: event['type'],
        repo_name: event['repo']['name'],
        languages: languages("#{event['repo']['url']}/languages"),
        created_at: event['created_at']}
    end
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
    response = RestClient.get(languages_url + "?client_id=#{@key}&client_secret=#{@secret}")
    JSON.parse(response.body)
  end

end

