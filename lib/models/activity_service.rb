class ActivityService

  def self.github_events user_name
    GithubClient.new.events_for_user(user_name).sort_by {|event|
      event[:created_at]
    }.reverse
  end

  def self.update_github consultants
    consultants.each do |consultant|
      events = self.github_events(consultant[:github_account])
      events.each do |event|
        GithubEvent.create(
          employee_id: consultant[:employee_id],
          event_id: event[:event_id],
          type: event[:type],
          repo_name: event[:repo_name],
          languages: event[:languages],
          created_at: event[:created_at]
        )
      end
    end
  end

end
