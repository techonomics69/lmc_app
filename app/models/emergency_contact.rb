class EmergencyContact < ApplicationRecord
	belongs_to :member
	validates :member_id, 			presence: true
	validates :address_1, 			presence: true, length: { maximum: 100 }
	validates :address_2, 			length: { maximum: 100 }
	validates :address_3,				length: { maximum: 100 }
	validates :town,      	  	presence: true, length: { maximum: 100 }
	validates :postcode,  			presence: true, length: { maximum: 8 }
	validates :country,   	  	presence: true
	validates :primary_phone,	  presence: true, length: { is: 11 }, numericality: true, allow_nil: true
	validates :secondary_phone,	length: { is: 11 }, numericality: true, allow_nil: true
	validates :relationship, 		presence: true, length: { maximum: 12 }
end
