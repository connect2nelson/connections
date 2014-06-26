class MeetupService
  def self.meetups(member_id)
    groups_part_of = RMeetup::Client.fetch(:groups, :member_id => member_id)
    events_ids = []
    groups_part_of.each do |group|
      events_ids += RMeetup::Client.fetch(:events, :group_id => group.id).map {|event| event.id }
    end
    rsvps = events_ids.map{|id|  RMeetup::Client.fetch(:rsvps, :event_id => id) }
    members_rsvps = []
    rsvps.map{|rsvp_set|
     members_rsvps += rsvp_set.select{|rsvp | rsvp.member_id == member_id}
    }
    return members_rsvps
  end

  def self.member_info(member_id)
    return RMeetup::Client.fetch(:members, :member_id => member_id)
  end
end