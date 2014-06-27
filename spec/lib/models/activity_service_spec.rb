require 'rails_helper'

describe ActivityService do

  describe '.github_events' do

    before do
      allow(GithubClient).to receive(:new)
        .and_return(github_client)
    end

    context 'user not found' do
      let(:github_client) {
        double(events_for_user: [])
      }
      it 'should return empty list' do
        expect(ActivityService.github_events('invalid_name')).to eq []
      end
    end

    context 'user found' do
      let(:event_one) {
        {repo_name: 'earlier', languagues: {"Ruby"=>1111}, created_at: '2014-06-23T21:35:13Z'}
      }
      let(:event_two) {
        {repo_name: 'later', languagues: {"Ruby"=>1234}, created_at: '2014-06-29T20:20:00Z'}
      }
      let(:github_client) {
        double(events_for_user: [event_one, event_two])
      }

      it 'should sort by time in descending order' do
        events = ActivityService.github_events('some_name')
        expect(events.size).to eq 2
        expect(events.first[:repo_name]).to eq 'later'
        expect(events.second[:repo_name]).to eq 'earlier'
      end
    end
  end

  describe '.update_github' do

    before do
      allow(ActivityService).to receive(:github_events)
        .with(consultant_one[:github_account])
        .and_return([{event_id: '1', repo_name: 'repo', type: 'PushEvent', languages: {}, created_at: ''}])
      allow(ActivityService).to receive(:github_events)
        .with(consultant_two[:github_account])
        .and_return([{event_id: '2', repo_name: 'repo', type: 'PushEvent', languages: {}, created_at: ''}])
    end

    let(:consultant_one) {
      {employee_id: '111', github_account: 'yo'}
    }
    let(:consultant_two) {
      {employee_id: '222', github_account: 'me'}
    }
    let(:consultants) {[consultant_one, consultant_two]}

    it 'should create event for each consultant' do
      expect(GithubEvent).to receive(:create).with({:employee_id=>'111', :event_id=>'1', :type=>'PushEvent', :repo_name => 'repo', :languages=> {}, :created_at => ''})
      expect(GithubEvent).to receive(:create).with({:employee_id=>'222', :event_id=>'2', :type=>'PushEvent', :repo_name => 'repo', :languages=> {}, :created_at => ''})
      ActivityService.update_github(consultants)
    end


  end

end
