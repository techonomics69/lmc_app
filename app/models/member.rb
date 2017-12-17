class Member < ApplicationRecord
	attr_accessor :selected
	has_one :membership, dependent: :destroy
	has_one :emergency_contact, dependent: :destroy
	has_many :meets
	accepts_nested_attributes_for :membership, :emergency_contact, :meets
	before_create { build_membership }
	before_create { build_emergency_contact }

	before_save { email.downcase! }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :first_name, 	 presence: true
	validates :last_name,    presence: true
	validates :address_1,    presence: true, length: { maximum: 100 }
	validates :address_2,		 length: { maximum: 100 }
	validates :address_3,		 length: { maximum: 100 }
	validates :town,       	 presence: true, length: { maximum: 100 }
	validates :postcode,   	 presence: true, length: { maximum: 10 }
	validates :country,    	 presence: true, inclusion: { in: COUNTRIES }
	validates :phone,	  		 length: { is: 11 }, numericality: true, allow_nil: true
	validates :email, 			 presence: true, length: { maximum: 255 },
													 format: { with: VALID_EMAIL_REGEX },
													 uniqueness: { case_sensitive: false }
	validates :dob,        	 presence: true
	validates :experience,   presence: true, length: { maximum: 500 }
	validates :accept_risks, inclusion: { in: [ true ] }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	def Member.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def full_name
		"#{first_name} #{last_name}"
	end

	PARTICIPATION_STATEMENT = "I accept that climbing and mountaineering are activities with a danger of personal injury or death. I am aware of and shall accept these risks and wish to participate in these activities voluntarily and shall be responsible for my own actions and involvement."
	
end
