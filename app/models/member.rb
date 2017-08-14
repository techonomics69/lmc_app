class Member < ApplicationRecord
	has_one :membership
	before_save { build_membership }

	before_save { email.downcase! }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :first_name, 	 presence: true
	validates :last_name,    presence: true
	validates :address_1,    presence: true, length: { maximum: 100 }
	validates :address_2,		 length: { maximum: 100 }
	validates :address_3,		 length: { maximum: 100 }
	validates :town,       	 presence: true, length: { maximum: 100 }
	validates :postcode,   	 presence: true, length: { maximum: 8 }
	validates :country,    	 presence: true
	validates :phone,	  		 length: { is: 11 }, numericality: true, allow_nil: true
	validates :email, 			 presence: true, length: { maximum: 255 },
													 format: { with: VALID_EMAIL_REGEX },
													 uniqueness: { case_sensitive: false }
	validates :dob,        	 presence: true
	validates :experience,   presence: true, length: { maximum: 500 }
	validates :accept_risks, inclusion: { in: [ true ] }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }


end
