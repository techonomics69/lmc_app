class EmergencyContact < ApplicationRecord
	belongs_to :member
	validates :member, 					presence: true
	validates :name, 						presence: true
	validates :address_1, 			presence: true, length: { maximum: 100 } #on: :update
	validates :address_2, 			length: { maximum: 100 }
	validates :address_3,				length: { maximum: 100 }
	validates :town,      	  	presence: true, length: { maximum: 100 }
	validates :postcode,  			presence: true, length: { maximum: 10 }
	validates :country,   	  	presence: true, inclusion: { in: COUNTRIES }
	validates :primary_phone,	  presence: true #allow_nil: true
#	validates :secondary_phone,	
	validates :relationship, 		presence: true, length: { maximum: 12 }
#	before_save { postcode.upcase! }

end
