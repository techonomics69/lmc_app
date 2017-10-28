require 'test_helper'

class MembersEditTest < ActionDispatch::IntegrationTest
	def setup
		@member = members(:test)
	end

	test "unsuccessful edit" do
		log_in_as(@member)
		get edit_member_path(@member)
		assert_template 'members/edit'
		patch member_path(@member), params: { member: { first_name: "",
																								  last_name: "",
																								  address_1: "",
																								  address_2: "",
																								  address_3: "",
																								  town: "",
																								  postcode: "",
																								  country: "",
																								  phone: "",
																								  email: "invalidexample",
																								  dob: "",
																								  experience: "",
																								  accept_risks: false,
																								  password: "foo",
																								  password_confirmation: "bar" } }
		assert_template 'members/edit'
		assert_select 'div.alert', "The form contains 14 errors."
	end

	test "successful edit with friendly forwarding" do
		get edit_member_path(@member)
		assert_equal session[:forwarding_url], edit_member_url(@member)
		log_in_as(@member)
		assert_redirected_to edit_member_url(@member)
		first_name = "Foo"
		last_name = "Bar"
		email = "foo@bar.com"
		patch member_path(@member), params: { member: { first_name: first_name,
																								  last_name: last_name,
																								  address_1: "1 Test",
																								  address_2: "",
																								  address_3: "",
																								  town: "Testown",
																								  postcode: "TE5 1ST",
																								  country: "United Kingdom",
																								  phone: "01234567891",
																								  email: email,
																								  dob: "1990-01-01",
																								  experience: "More experience",
																								  accept_risks: true,
																								  password: "",
																								  password_confirmation: "" } }
		assert_not flash.empty?
		assert_redirected_to @member
		@member.reload
		assert_equal first_name, @member.first_name
		assert_equal last_name, @member.last_name
		assert_equal email, @member.email
	end
end
