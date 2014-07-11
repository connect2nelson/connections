require 'spec_helper'

describe GithubClient do

  describe '#events_for_user' do

    context 'returns 200 OK' do

      let(:user_name) {'some_name'}
      let(:events) {
        [{'id'=>'1','type'=>'PushEvent',
         'created_at'=>'2014-06-23T21:35:13Z',
         'repo'=> {'name'=>'thoughtworks/connections','url'=>'https://api.github.com/repos/thoughtworks/connections'}
        }]
      }
      let(:languages) {
        {'Ruby'=> 1111, 'Java'=> 1234}
      }

      before do
        @github_client = GithubClient.new
        allow(EtagRequestService).to receive(:create)
          .with(/\/events/).and_return(EtagResponse.new(double(body: events.to_json)))
        allow(EtagRequestService).to receive(:create)
          .with(/\/languages/).and_return(EtagResponse.new(double(body: languages.to_json)))
        @events = @github_client.events_for_user(user_name)
      end

      it 'should return repo name' do
        expect(@events.size).to eq 1
        expect(@events.first[:repo_name]).to eq 'thoughtworks/connections'
      end

      it 'should return languagues' do
        expect(@events.first[:languages].size).to eq 2
        expect(@events.first[:languages][:Ruby]).to eq 1111
        expect(@events.first[:languages][:Java]).to eq 1234
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

    end
  end
end
