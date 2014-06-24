if ENV["MEETUP_API_KEY"]
  RMeetup::Client.api_key = ENV["MEETUP_API_KEY"]
end
