class Member < ApplicationRecord
	attr_accessor :selected
	has_one :membership, dependent: :destroy
	has_one :emergency_contact, dependent: :destroy
	has_many :meets
	accepts_nested_attributes_for :membership, :emergency_contact, :meets
	before_create { build_membership }
	before_create { build_emergency_contact }

	before_save { email.downcase! }
	TITLES = ["Mr", "Mrs", "Miss", "Ms", "Dr", "Prof", "Rev"]
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :title, 	 		 presence: true#, inclusion: { in: TITLES }
	validates :first_name, 	 presence: true
	validates :last_name,    presence: true
	validates :address_1,    presence: true, length: { maximum: 100 }
	validates :address_2,		 length: { maximum: 100 }
	validates :address_3,		 length: { maximum: 100 }
	validates :town,       	 presence: true, length: { maximum: 50 }
	validates :county,			 presence: true, length: {maximum: 20 }
	validates :postcode,   	 presence: true, length: { maximum: 10 }
	validates :country,    	 presence: true, inclusion: { in: COUNTRIES }
	validates :home_phone,	 length: { is: 11 }, numericality: true, allow_blank: true
	validates :mob_phone,	 	 length: { is: 11 }, numericality: true, allow_blank: true
	validates :email, 			 presence: true, length: { maximum: 255 },
													 format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
	validates :dob,        	 presence: true
	validates :experience,   presence: true, length: { maximum: 500 }
	validates :accept_risks, inclusion: { in: [ true ] }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv.add_row column_names
			all.each do |member|
				values = member.attributes.values
				csv.add_row values
			end
		end
	end

	def self.to_csv_members(member_atts = DEFAULT_MEMBER_ATTS, options = {})
		CSV.generate(options) do |csv|
			csv << member_atts

			all.each do |member|
				values = member.attributes.values_at(*member_atts)
				csv << values
			end
		end
	end

	def self.to_csv_for_bmc(member_atts = BMC_MEMBER_ATTS, membership_atts = BMC_MEMBERSHIP_ATTS, options = {})
		CSV.generate(options) do |csv|
			csv << membership_atts + member_atts

			all.each do |member|
				values = member.membership.attributes.slice(*membership_atts).values_at(*membership_atts) if member.membership
				values += member.attributes.values_at(*member_atts)
				csv << values
			end
		end
	end

	def self.to_csv_membership(member_atts = ["first_name", "last_name"], membership_atts = DEFAULT_MEMBERSHIP_ATTS, options = {})
		CSV.generate(options) do |csv|
			csv << member_atts + membership_atts

			all.each do |member|
				values = member.attributes.values_at(*member_atts)
				values += member.membership.attributes.slice(*membership_atts).values_at(*membership_atts) if member.membership
				csv << values
			end
		end
	end

	def self.to_csv_emergency_contact(member_atts = ["first_name", "last_name"], em_contact_atts = DEFAULT_EM_CONT_ATTS, options = {})
		CSV.generate(options) do |csv|
			csv << ["MEMBER", "", "EMERGENCY CONTACT"]
			csv << member_atts + em_contact_atts

			all.each do |member|
				values = member.attributes.values_at(*member_atts)
				values += member.emergency_contact.attributes.slice(*em_contact_atts).values_at(*em_contact_atts) if member.emergency_contact
				csv << values
			end
		end
	end

	def self.to_csv_with_membership_and_emergency_contact(member_atts = DEFAULT_MEMBER_ATTS,
																												membership_atts = DEFAULT_MEMBERSHIP_ATTS, 
																												em_contact_atts = DEFAULT_EM_CONT_ATTS,
																												options = {})
		CSV.generate(options) do |csv|
			csv << ["MEMBER", "","","","","","","","","","","","","","MEMBERSHIP","","","","","","","", "EMERGENCY CONTACT"]
			csv << member_atts + membership_atts + em_contact_atts

			all.each do |member|
				values = member.attributes.slice(*member_atts).values_at(*member_atts)
				values += member.membership.attributes.slice(*membership_atts).values_at(*membership_atts) if member.membership
				values += member.emergency_contact.attributes.slice(*em_contact_atts).values_at(*em_contact_atts) if member.emergency_contact
				csv << values
			end
		end
	end

	def Member.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def full_name
		"#{title} #{first_name} #{last_name}"
	end

	DEFAULT_MEMBER_ATTS =  ["first_name", 
													"last_name", 
													"email",
													"home_phone",
													"mob_phone",
													"address_1",
													"address_2", 
													"address_3",
													"town",
													"county",
													"postcode",
													"country",
													"dob",
													"experience"]

	DEFAULT_MEMBERSHIP_ATTS = ["bmc_number",
														 "membership_type",
														 "subs_paid",
														 "fees_received_on",
														 "made_full_member",
														 "welcome_pack_sent",
														 "committee_position",
														 "notes"]

	DEFAULT_EM_CONT_ATTS = ["name",
													"relationship",
													"address_1",
													"address_2",
													"address_3",
													"town",
													"postcode",
													"country",
													"primary_phone",
													"secondary_phone"]

	BMC_MEMBER_ATTS =  ["title",
											"first_name", 
											"last_name",
											"dob",
											"address_1",
											"address_2", 
											"address_3",
											"town",
											"county",
											"postcode",																					
											"email",
											"home_phone",
											"mob_phone"]

	BMC_MEMBERSHIP_ATTS = ["bmc_number"]

	PARTICIPATION_STATEMENT = "I accept that climbing and mountaineering are activities with a danger of personal injury or death. I am aware of and shall accept these risks and wish to participate in these activities voluntarily and shall be responsible for my own actions and involvement."
	
end
