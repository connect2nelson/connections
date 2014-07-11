class GithubClient

  def initialize
    @base_url = "https://api.github.com"
    @credentials = "?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}"
  end

  def events_for_user user_name
    event_url = "#{@base_url}/users/#{user_name}/events"
    events = EtagRequestService.create(event_url).as_array
    events.inject([]) { |all, e| all << create_event(e) if allowed_type?(e); all }
  end



  private

  def create_event event
    { event_id: event[:id],
      type: event[:type],
      repo_name: event[:repo][:name],
      languages: EtagRequestService.create("#{event[:repo][:url]}/languages").as_hash,
      created_at: event[:created_at],
      avatar: event[:actor][:avatar_url]}
  end

  def allowed_type? event
    event[:type] == "PushEvent"
  end

end
