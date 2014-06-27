class GithubClient

  def events_for_user user_name
    events(user_name).map do |event|
      puts languages("#{event['repo']['url']}/languages")
      { repo_name: event['repo']['name'],
        languages: languages("#{event['repo']['url']}/languages"),
        created_at: event['created_at']}
    end
  end

  private

  def events user_name
    begin
      response = RestClient.get("https://api.github.com/users/#{user_name}/events")
    rescue => e
      return []
    end
    JSON.parse(response.body)
  end

  def languages languages_url
    response = RestClient.get(languages_url)
    JSON.parse(response.body)
  end

end

