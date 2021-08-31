module MeetsHelper
  def find_meet_leader(meet)
    attendee_leader = meet.attendees.where(meet_id: meet.id, is_meet_leader: true)
    Member.find(attendee_leader.first.member_id) unless attendee_leader.empty?
  end

  def meet_leader?(member, meet)
    meet_leader = find_meet_leader(meet)
    meet_leader == member
  end

  def member_is_on_meet?(member_id, meet_id)
    Attendee.where(member_id: member_id, meet_id: meet_id).exists?
  end
end
