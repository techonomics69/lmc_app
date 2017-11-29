module MembersHelper

	def membership_level(member)
		if member.membership.committee_position
			"#{member.membership.committee_position}"
		else
			"#{member.membership.membership_type} Member"
		end
	end

	def committee_member?(member)
		!member.membership.committee_position.nil?
	end

	def latest_update(member)
		updates = [member.updated_at, member.membership.updated_at]
		updates.max.strftime("%d/%m/%Y")
	end

	def new_member?(member)
		membership_level(member) == "Provisional (unpaid) Member"
	end
end
