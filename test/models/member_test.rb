require 'test_helper'

class MemberTest < ActiveSupport::TestCase
	def setup
		@member = Member.new(
#												 title: "Mr",
												 first_name: "name", 
												 last_name: "surname",
												 address_1: "House Name",
												 address_2: "1 My Road", 
												 address_3: "My Estate",
												 town: "Test Town",
												 county: "West Yorkshire",
												 postcode: "TE51 1AA",
												 country: "United Kingdom",
												 home_phone: "07798976256",
												 mob_phone: "01234567898",
												 email: "user@example.com", 
												 dob:"09-05-1990",
												 experience:"I've done some mountaineering and rock climbing before.",
												 accept_risks: true,
												 password: "password",
												 password_confirmation: "password"
												 )
	end

	test "should be valid" do
		assert @member.valid?
	end

#	test "title should be present" do
#		@member.title = "    "
#		assert_not @member.valid?
#	end

#first_name
	test "first_name should be present" do
		@member.first_name = "    "
		assert_not @member.valid?
	end

#last_name
	test "last_name should be present" do
		@member.last_name = "    "
		assert_not @member.valid?
	end

#addresses
	test "address_1 should be present" do
		@member.address_1 = "     "
		assert_not @member.valid?
	end

	test "each address line should not be too long" do
		@member.address_1 = "a"*101
		@member.address_2 = "a"*101
		@member.address_3 = "a"*101
		assert_not @member.valid?
	end

#town
	test "town should be present" do
		@member.town = "   "
		assert_not @member.valid?
	end

	test "town should not be too long" do
		@member.town = "a"*101
		assert_not @member.valid?
	end

#county
	test "county should be present" do
		@member.county = "   "
		assert_not @member.valid?
	end

	test "county should not be too long" do
		@member.county = "a"*101
		assert_not @member.valid?
	end

#postcode
	test "postcode should be present" do
		@member.postcode = "   "
		assert_not @member.valid?
	end

	test "postcode should not be too long" do
		@member.postcode = "a"*12
		assert_not @member.valid?
	end

#country
	test "country should be present" do
		@member.country = "   "
		assert_not @member.valid?
	end

#phone
	test "phone should be 11 digits" do
		@member.home_phone = /\d{11}/
		assert_not @member.valid?
		@member.mob_phone = /\d{11}/
		assert_not @member.valid?
	end

#email
	test "email should be present" do
		@member.email = "    "
		assert_not @member.valid?
	end

	test "email should not be too long" do
		@member.email = "a"*244 + "@example.com"
		assert_not @member.valid?
	end

	test "email address should be unique" do
		duplicate_member = @member.dup
		duplicate_member.email = @member.email.upcase
		@member.save
		assert_not duplicate_member.valid?
	end

	test "email addresses should be saved as lower case" do
		mixed_case_email = "Foo@ExAMPle.coM"
		@member.email = mixed_case_email
		@member.save
		assert_equal mixed_case_email.downcase, @member.reload.email
	end

#dob
	test "date should be present" do
		@member.dob = "    "
		assert_not @member.valid?
	end

	test "experience should not be too long" do
		@member.experience = "a"*501
		assert_not @member.valid?
	end

#accept_risks
	test "accept_risks must be true" do
		@member.accept_risks = true
		assert @member.valid?
	end

	#password
	test "password should be present (nonblank)" do
		@member.password = @member.password_confirmation = " "*6
		assert_not @member.valid?
	end

	test "password should have a minimum length" do 
		@member.password = @member.password_confirmation = "a"*5
		assert_not @member.valid?
	end

end
