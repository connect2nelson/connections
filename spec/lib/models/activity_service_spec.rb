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

    context 'no moped errors thrown' do

      before do
        github_client = double
        allow(GithubClient).to receive(:new).and_return(github_client)
        allow(github_client).to receive(:events_for_user)
          .with(consultant_one[:github_account])
          .and_return(events_for_consultant_one)
        allow(github_client).to receive(:events_for_user)
          .with(consultant_two[:github_account])
          .and_return(events_for_consultant_two)
      end

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

      it 'should persist unique event for each consultant' do
        expect(GithubEvent).to receive(:create).with({:employee_id=>'111', :event_id=>'1', :type=>'PushEvent', :repo_name => 'repo', :languages=> {}, :created_at => ''})
        expect(GithubEvent).to receive(:create).with({:employee_id=>'222', :event_id=>'2', :type=>'PushEvent', :repo_name => 'repo', :languages=> {}, :created_at => ''})
        ActivityService.update_github(consultants)
      end
    end

    context 'moped error thrown' do

      before do
        github_client = double
        allow(GithubClient).to receive(:new).and_return(github_client)
        allow(github_client).to receive(:events_for_user)
          .with(consultant[:github_account])
          .and_return(events_for_consultant)
        allow(GithubEvent).to receive(:create).and_raise(error)
      end

      context 'duplicate entry' do
        let(:consultant) {
          {employee_id: '111', github_account: 'yo'}
        }
        let(:consultants) {[consultant]}
        let(:events_for_consultant) { [{}] }
        let(:error) { Moped::Errors::OperationFailure.new("duplicate key", {'code'=> 11000}) }

        it 'should catch duplicate key error for the second event ' do
          expect(Rails.logger).to receive(:info)
          ActivityService.update_github(consultants)
        end

      end

      context 'any other failure' do
        let(:consultant) {
          {employee_id: '111', github_account: 'yo'}
        }
        let(:consultants) {[consultant]}
        let(:events_for_consultant) { [{}] }
        let(:error) { Moped::Errors::OperationFailure.new("any other failure", {'code'=> 20000}) }

        it 'raise error' do
          expect{ActivityService.update_github(consultants)}.to raise_error(error)
        end

      end
    end

  end

end
