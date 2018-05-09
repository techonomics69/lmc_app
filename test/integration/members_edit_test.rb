require 'test_helper'

class MembersEditTest < ActionDispatch::IntegrationTest
	def setup
		@member = members(:climber)
	end

	test "unsuccessful edit" do
		log_in_as(@member)
		get edit_member_path(@member)
		assert_template 'members/edit'
		patch member_path(@member), params: { member: { 
		#																							title: "",
																									first_name: "",
																								  last_name: "",
																								  address_1: "",
																								  address_2: "",
																								  address_3: "",
																								  town: "",
																								  county: "",
																								  postcode: "",
																								  country: "",
																								  home_phone: "",
																								  mob_phone: "",
																								  email: "invalidexample",
																								  dob: "",
																								  experience: "",
																								  accept_risks: false,
																								  password: "foo",
																								  password_confirmation: "bar" } }
		assert_template 'members/edit'
		assert_select 'div.alert', "The form contains 13 errors."
	end

	test "successful edit with friendly forwarding" do
		get edit_member_path(@member)
		assert_equal session[:forwarding_url], edit_member_url(@member)
		log_in_as(@member)
		assert_redirected_to edit_member_url(@member)
		first_name = "Foo"
		last_name = "Bar"
		email = "foo@bar.com"
		bmc_no = "A12345"
		patch member_path(@member), params: { member: { 
		#																							title: "Mrs",
																									first_name: first_name,
																								  last_name: last_name,
																								  address_1: "1 Test",
																								  address_2: "",
																								  address_3: "",
																								  town: "Testown",
																								  county: "English County",
																								  postcode: "TE5 1ST",
																								  country: "United Kingdom",
																								  home_phone: "01234567891",
																								  mob_phone: "09877646543",
																								  email: email,
																								  dob: "1990-01-01",
																								  experience: "More experience",
																								  accept_risks: true,
																								  receive_emails: false,
																								  password: "",
																								  password_confirmation: "",
																								  membership_attributes: {
																									  bmc_number: bmc_no } } }
		assert_not flash.empty?
		assert_redirected_to @member
		@member.reload
		assert_equal first_name, @member.first_name
		assert_equal last_name, @member.last_name
		assert_equal bmc_no, @member.membership.bmc_number
		assert_equal email, @member.email
	end

	test "email subscribe/unsubscribe" do
		log_in_as(@member)
		get member_path(@member)
		assert_equal true, @member.receive_emails
		patch email_subscribe_member_path(@member)
		@member.reload
		assert_equal false, @member.receive_emails
	end
end
