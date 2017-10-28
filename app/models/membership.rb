class Membership < ApplicationRecord
	belongs_to :member
	validates :member, presence: true
	validates :membership_type, inclusion: { in: ["Provisional","Full","Honorary","Lapsed"] }
	validates :welcome_pack_sent, inclusion: { in: [ true, false ] }



end
