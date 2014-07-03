require 'rails_helper'

describe GithubClient do

  describe '#events_for_user' do

    context 'user found' do

      context 'no new events' do
        let(:event_response) {
          double(code: 304)
        }

        before do
          @github_client = GithubClient.new

          allow(ApiCall).to receive(:find_by)
            .and_return({etag: 'Un1q1DeNt1f1er'})

          @events = @github_client.events_for_user("some_name")
        end

        it 'should return empty list' do
          expect(@events.size).to eq 0
        end

      end

      context 'new events' do

        let(:event_response) {
          double(code: 200, body: [Hash['id'=>'1','type'=>'PushEvent','created_at'=>'2014-06-23T21:35:13Z','actor'=>Hash['avatar_url'=>'https://avatars.githubusercontent.com/u/784889?'],'repo'=>Hash['name'=>'thoughtworks/connections','url'=>'https://api.github.com/repos/thoughtworks/connections']]].to_json )
        }
        let(:languages_response) {
          double(code: 200, body: Hash['Ruby'=> 1111, 'Java'=> 1234].to_json)
        }

        before do
          @github_client = GithubClient.new

          allow(ApiCall).to receive(:find_by)
            .and_return({etag: 'D1fFerent1DeNt1f1er'})

          event_request = double
          allow(RestClient::Resource).to receive(:new)
            .with(/\/events/)
            .and_return(event_request)
          allow(event_request).to receive(:get)
            .and_return(event_response)

          languages_request = double
          allow(RestClient::Resource).to receive(:new)
            .with(/\/languages/)
            .and_return(languages_request)
          allow(languages_request).to receive(:get)
            .and_return(languages_response)

          @events = @github_client.events_for_user("some_name")
        end

        it 'should return repo name' do
          expect(@events.size).to eq 1
          expect(@events.first[:repo_name]).to eq 'thoughtworks/connections'
        end

        it 'should return languagues' do
          expect(@events.first[:languages].size).to eq 2
          expect(@events.first[:languages]["Ruby"]).to eq 1111
          expect(@events.first[:languages]["Java"]).to eq 1234
        end

        it 'should return created_at time' do
          expect(@events.first[:created_at]).to eq "2014-06-23T21:35:13Z"
        end

        it 'should return id' do
          expect(@events.first[:event_id]).to eq "1"
        end

        it 'should return type' do
          expect(@events.first[:type]).to eq "PushEvent"
        end

        it 'should return avatar url' do
            expect(@events.first[:avatar]).to eq "https://avatars.githubusercontent.com/u/784889?"
        end

      end

    end

  end

  context 'user not found' do

      before do
        @github_client = GithubClient.new

        allow(ApiCall).to receive(:find_by)
          .with({url: /\/users\/some_name\/events/})
          .and_return({})

        event_request = double
        allow(RestClient::Resource).to receive(:new)
          .with(/\/events/)
          .and_return(event_request)
        allow(event_request).to receive(:get)
          .and_raise(RestClient::Exception)
        @events = @github_client.events_for_user("some_name")
      end


    it 'should return empty list' do
      expect(@events.size).to eq 0
    end

  end

end
