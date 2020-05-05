module MeetsHelper
  def find_meet_leader(meet)
    meet_leader = meet.attendees.find {|attendee| attendee.is_meet_leader == true } 
    return meet_leader ? meet.members.find_by_id(meet_leader.member_id) : nil
  end
end
