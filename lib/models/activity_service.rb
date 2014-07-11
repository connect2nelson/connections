class ActivityService

  def self.update_github consultants
    consultants.each do |consultant|
      self.new(consultant).update_github_for_consultant
    end
  end

  def self.github_events employee_id
    GithubEvent.where(employee_id: employee_id).sort_by {|event| event[:created_at]}.reverse
  end

  def initialize consultant
    @consultant = consultant
  end

  def update_github_for_consultant
    new_events.each do |event|
      persist_event event
    end
  end

  private

  def event_ids
    @event_ids ||= GithubEvent.where(employee_id: @consultant[:employee_id]).pluck(:event_id)
  end

  def new_events
    all_events = GithubClient.new.events_for_user(@consultant[:github_account])
    all_events.reject { |event| event_ids.include?(event[:event_id]) }
  end

  def persist_event(event)
    repo = GithubRepository.find_or_create_by(repo_name: event[:repo_name])
    repo.update_attributes(languages: event[:languages]) unless event[:languages].empty?
    GithubEvent.create(
      employee_id: @consultant[:employee_id],
      event_id: event[:event_id],
      type: event[:type],
      created_at: event[:created_at],
      github_repository: repo)
  end
end
