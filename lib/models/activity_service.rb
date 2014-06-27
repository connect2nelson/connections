class ActivityService

  def self.github_events user_name
    GithubClient.new.events_for_user(user_name).sort_by {|event|
      event[:created_at]
    }.reverse
  end

end
