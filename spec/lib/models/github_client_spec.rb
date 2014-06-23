require 'rails_helper'

describe GithubClient do

  context '#events_for_user' do

    before do
      @github_client = GithubClient.new
      @user_name = 'user_name'
      allow(RestClient).to receive(:get)
        .with("https://api.github.com/users/#{@user_name}/events")
        .and_return([Hash['repo'=>Hash['name'=>'thoughtworks/connections','url'=>'https://api.github.com/repos/thoughtworks/connections']]].to_json)
      allow(RestClient).to receive(:get)
        .with('https://api.github.com/repos/thoughtworks/connections/languages')
        .and_return(Hash['Ruby'=>1111, 'Java'=>1234].to_json)
    end

    it 'should return repo name' do
      events = @github_client.events_for_user(@user_name)
      expect(events.size).to eq 1
      expect(events.first[:repo_name]).to eq 'thoughtworks/connections'
    end

    it 'should return languagues' do
      events = @github_client.events_for_user(@user_name)
      expect(events.first[:languages].size).to eq 2
      expect(events.first[:languages]["Ruby"]).to eq 1111
      expect(events.first[:languages]["Java"]).to eq 1234
    end
  end


end
