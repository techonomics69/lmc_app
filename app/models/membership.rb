class Membership < ApplicationRecord
	belongs_to :member
	before_save :update_date_made_full, if: :membership_type_changed?
	after_find :update_subs_paid#, if: :fees_received_on_changed?
#	before_save :update_to_honorary, if: :membership_type_changed?

	include ActiveModel::Dirty

	COMMITTEE_POSITIONS = ["Chair",
												 "Treasurer",
												 "Meets Secretary",
												 "Membership Secretary",
												 "Communications Secretary",
												 "Social Secretary",
												 "Climbing Co-ordinator",
												 "Walking Co-ordinator",
												 "Ordinary Member",
												 "Member Without Portfolio"]

	MEMBERSHIP_TYPES = ["Provisional","Full","Honorary","Provisional (unpaid)"]

	validates :member, presence: true
	validates :membership_type, inclusion: { in: MEMBERSHIP_TYPES }
	validates :welcome_pack_sent, inclusion: { in: [ true, false ] }
	validates :subs_paid, inclusion: { in: [ true, false ] }
	validates :committee_position, inclusion: { in: COMMITTEE_POSITIONS }, uniqueness: true, allow_nil: true

	private

	def update_date_made_full
		if self.membership_type_change == ["Provisional", "Full"]
			self.made_full_member = DateTime.now
		end
	end

	def update_subs_paid
		if self.fees_received_on.nil?
			self.subs_paid = false
		elsif self.fees_received_on.year == DateTime.now.year
			self.subs_paid = true
		elsif self.fees_received_on.month.between?(10,12) && self.fees_received_on.year == (DateTime.now - 365.days).year
			self.subs_paid = true
		else
			self.subs_paid = false
		end
		self.membership_type = "Provisional" if self.subs_paid == true && self.membership_type == "Provisional (unpaid)"
		self.subs_paid = true if self.membership_type == "Honorary"
		self.save
	end


end
