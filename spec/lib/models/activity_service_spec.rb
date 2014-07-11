require 'rails_helper'

describe ActivityService do

  describe '.github_events' do

    before do
      allow(GithubEvent).to receive(:where)
        .with({employee_id: employee_id})
        .and_return(events)
    end

    context 'github events found' do
      let(:employee_id) { '1234' }
      let(:event_one) {
        {repo_name: 'earlier', languagues: {"Ruby"=>1111}, created_at: '2014-06-23T21:35:13Z'}
      }
      let(:event_two) {
        {repo_name: 'later', languagues: {"Ruby"=>1234}, created_at: '2014-06-29T20:20:00Z'}
      }
      let(:events) { [event_one, event_two] }

      it 'should sort by time in descending order' do
        events = ActivityService.github_events(employee_id)
        expect(events.size).to eq 2
        expect(events.first[:repo_name]).to eq 'later'
        expect(events.second[:repo_name]).to eq 'earlier'
      end
    end
  end

  describe '.update_github' do

    context 'all new events' do

      before do
        allow(GithubClient).to receive(:new).and_return(github_client)
        allow(github_client).to receive(:events_for_user)
          .with(consultant_one[:github_account])
          .and_return(events_for_consultant_one)
        allow(github_client).to receive(:events_for_user)
          .with(consultant_two[:github_account])
          .and_return(events_for_consultant_two)
      end

      let(:github_client) { double }
      let(:consultant_one) {
        {employee_id: '111', github_account: 'yo'}
      }
      let(:consultant_two) {
        {employee_id: '222', github_account: 'me'}
      }
      let(:consultants) {[consultant_one, consultant_two]}
      let(:events_for_consultant_one) {
        [{event_id: '1', repo_name: 'repo', type: 'PushEvent', languages: {}, created_at: ''}]
      }
      let(:events_for_consultant_two) {
        [{event_id: '2', repo_name: 'repo', type: 'PushEvent', languages: {}, created_at: ''}]
      }
      let(:some_languages) { Hash['Ruby' => 1, 'Java' => 5] }
      let(:events_for_consultant_two_with_languages) {
        [{event_id: '2', repo_name: 'repo', type: 'PushEvent', languages: some_languages, created_at: ''}]
      }
      let(:repository) { GithubRepository.new }

      it 'should persist unique event for each consultant' do
        allow(GithubRepository).to receive(:find_or_create_by).and_return repository
        expect(GithubEvent).to receive(:create).with({:employee_id=>'111', :event_id=>'1', :type=>'PushEvent', :created_at => '', :github_repository => repository})
        expect(GithubEvent).to receive(:create).with({:employee_id=>'222', :event_id=>'2', :type=>'PushEvent', :github_repository => repository, :created_at => ''})
        ActivityService.update_github(consultants)
      end

      it 'should persist github repo' do
        allow(GithubEvent).to receive(:create)
        expect(GithubRepository).to receive(:find_or_create_by).with(:repo_name=>'repo').twice
        ActivityService.update_github(consultants)
      end

      it 'should update languages when not empty' do
        allow(GithubEvent).to receive(:create)
        allow(GithubRepository).to receive(:find_or_create_by).and_return repository
        allow(github_client).to receive(:events_for_user)
          .with(consultant_two[:github_account])
          .and_return(events_for_consultant_two_with_languages)
        expect(repository).to receive(:update_attributes).with(languages: some_languages)
        ActivityService.update_github(consultants)
      end

      it 'should not update languages when empty' do
        allow(GithubEvent).to receive(:create)
        allow(GithubRepository).to receive(:find_or_create_by).and_return repository
        expect(repository).to receive(:update_attributes).with(languages: some_languages).never
        ActivityService.update_github(consultants)
      end
    end

    context 'some old events' do
      let(:events_for_consultant) { [{event_id: '3', languages: {}}, {event_id: '4', languages: {}}, {event_id: '5', languages: {}}] }
      let(:existing_event_ids) { ['1', '2', '3'] }
      let(:consultant) {
        {employee_id: '111', github_account: 'yo'}
      }
      let(:consultants) {[consultant]}

      before do
        github_client = double
        pluckable_events = double
        allow(GithubClient).to receive(:new).and_return(github_client)
        allow(github_client).to receive(:events_for_user)
          .with(consultant[:github_account])
          .and_return(events_for_consultant)
        allow(GithubEvent).to receive(:where)
          .with(employee_id: consultant[:employee_id])
          .and_return(pluckable_events)
        allow(pluckable_events).to receive(:pluck)
          .with(:event_id)
          .and_return(existing_event_ids)
        allow(GithubEvent).to receive(:where)
          .with(hash_including("github_repository_id"))
      end

      it 'should only persist new events' do
        expect(GithubEvent).to receive(:create).twice
        ActivityService.update_github(consultants)
      end
    end

  end

end
