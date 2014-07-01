class ActivityService

  class << self
    def update_github consultants
      consultants.each do |consultant|
        update_github_for_consultant consultant
      end
    end

    def github_events employee_id
      GithubEvent.where(employee_id: employee_id).sort_by {|event| event[:created_at]}.reverse
    end

    private

    def update_github_for_consultant(consultant)
      GithubClient.new.events_for_user(consultant[:github_account]).each do |event|
        persist_event consultant, event
      end
    end

    def persist_event(consultant, event)
      GithubEvent.create(
        employee_id: consultant[:employee_id],
        event_id: event[:event_id],
        type: event[:type],
        repo_name: event[:repo_name],
        languages: event[:languages],
        created_at: event[:created_at],
        avatar: event[:avatar])
    rescue Moped::Errors::OperationFailure => e
      raise e unless duplicate_key_error?(e)
      Rails.logger.info "duplicate event #{event[:event_id]} found for employee #{consultant[:employee_id]}"
    end

    def duplicate_key_error? e
      e.details['code'] == 11000
    end
  end

end
