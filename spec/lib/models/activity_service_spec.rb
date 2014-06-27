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


end
