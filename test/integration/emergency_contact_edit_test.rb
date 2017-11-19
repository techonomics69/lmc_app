require 'test_helper'

class EmergencyContactEditTest < ActionDispatch::IntegrationTest
	def setup
		@member = members(:climber)
	end

	test "unsuccessful edit" do
		log_in_as(@member)
		get emergency_contact_member_path(@member)
		assert_template 'emergency_contact/edit'
		patch emergency_contact_member_path(@member), params: { member: { emergency_contact_attributes: { 
																										id: @member.emergency_contact.id,
  																									name: "",
  																								  address_1: "",
																									  address_2: "",
																									  address_3: "",
																									  town: "",
																									  postcode: "",
																									  country: "",
																									  primary_phone: "",
																									  secondary_phone: "",
  																									relationship: "" } } }
		assert_template 'emergency_contact/edit'
		assert_select 'div.alert', "The form contains 8 errors."
	end

	test "successful edit with friendly forwarding" do
		get emergency_contact_member_path(@member)
		assert_equal session[:forwarding_url], emergency_contact_member_url(@member)
		log_in_as(@member)
		assert_redirected_to emergency_contact_member_url(@member)
		name = "Their Name"
		relationship = "Mother"
		primary_phone = "12345678901"
		patch emergency_contact_member_path(@member), params: { member: { emergency_contact_attributes: { 
																										id: @member.emergency_contact.id,
  																									name: "Their Name",
  																								  address_1: "Some Street",
																									  address_2: "",
																									  address_3: "",
																									  town: "Some Town",
																									  postcode: "LS9 9PW",
																									  country: "United Kingdom",
																									  primary_phone: "12345678901",
																									  secondary_phone: "09876543212",
  																									relationship: "Mother" } } }
		assert_not flash.empty?
		assert_redirected_to @member
		@member.reload
		assert_equal name, @member.emergency_contact.name
		assert_equal relationship, @member.emergency_contact.relationship
		assert_equal primary_phone, @member.emergency_contact.primary_phone
	end
end
