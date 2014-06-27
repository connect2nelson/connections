class ActivityService

  def self.update_github consultants
    consultants.each do |consultant|
      events = GithubClient.new.events_for_user(consultant[:github_account])
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

  def self.github_events employee_id
    GithubEvent.where(employee_id: employee_id).sort_by {|event| event[:created_at]}.reverse
  end

end
