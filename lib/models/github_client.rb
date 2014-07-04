class GithubClient

  def initialize
    @base_url = "https://api.github.com"
    @credentials = "?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}"
  end

  def events_for_user user_name
    event_url = "#{@base_url}/users/#{user_name}/events"
    EtagRequestService.create(event_url).inject([]) { |all, e| all << create_event(e) if allowed_type?(e); all }
  end

  private

  # don't want to save the old ones
  def create_event event
    { event_id: event['id'],
      type: event['type'],
      repo_name: event['repo']['name'],
      languages: EtagRequestService.create("#{event['repo']['url']}/languages"),
      created_at: event['created_at'],
      avatar: event['actor']['avatar_url']}
  end

  def allowed_type? event
    event['type'] == "PushEvent"
  end

end
