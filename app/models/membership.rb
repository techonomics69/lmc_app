class Membership < ApplicationRecord
	belongs_to :member
	validates :member_id, presence: true
	validates :membership_type, inclusion: { in: ["Provisional","Full","Honorary","Lapsed"] }
	validates :welcome_pack_sent, inclusion: { in: [ true, false ] }



end
