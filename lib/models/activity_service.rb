class ActivityService

  def self.update_github consultants
    consultants.each do |consultant|
      GithubClient.new.events_for_user(consultant[:github_account]).each do |event|
        begin
          persist_event(consultant, event)
        rescue Moped::Errors::OperationFailure => e
          unless duplicate_key_error?(e)
            raise e
          end
          Rails.logger.info "duplicate event #{event[:event_id]} found for employee #{consultant[:employee_id]}"
        end
      end
    end
  end

  def self.github_events employee_id
    GithubEvent.where(employee_id: employee_id).sort_by {|event| event[:created_at]}.reverse
  end

  private

  def self.persist_event(consultant, event)
    GithubEvent.create(
      employee_id: consultant[:employee_id],
      event_id: event[:event_id],
      type: event[:type],
      repo_name: event[:repo_name],
      languages: event[:languages],
      created_at: event[:created_at])
  end

  def self.duplicate_key_error? e
    e.details['code'] == 11000
  end

end
