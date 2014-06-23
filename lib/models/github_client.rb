class GithubClient

  def events_for_user user_name
    events(user_name).map do |event|
      { repo_name: event['repo']['name'],
        languages: languages("#{event['repo']['url']}/languages")
      }
    end
  end

  private

  def events user_name
    result = RestClient.get("https://api.github.com/users/#{user_name}/events")
    JSON.parse(result)
  end

  def languages languages_url
    JSON.parse(RestClient.get(languages_url))
  end

end

