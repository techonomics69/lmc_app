module MeetsHelper
  def find_meet_leader(meet)
    meet_leader = meet.attendees.find {|attendee| attendee.is_meet_leader == true } 
    return meet_leader ? meet.members.find_by_id(meet_leader.member_id) : nil
  end

  def meet_leader?(member, meet)
    meet_leader = find_meet_leader(meet)
    return meet_leader == member
  end
end
