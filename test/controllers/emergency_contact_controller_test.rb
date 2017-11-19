require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest

	def setup
		@member = members(:luke)
		@other_member = members(:climber)
	end

  test "ec controller should redirect edit when logged in as wrong member" do
  	log_in_as(@other_member)
  	get emergency_contact_member_path(@member)
  	assert flash.empty?
  	assert_redirected_to root_url
  end

  test "ec controller should redirect update when logged in as wrong member" do
  	log_in_as(@other_member)
  	patch emergency_contact_member_path(@member), params: { member: { #first_name: @member.first_name,
  																																		#last_name: @member.last_name,
  																																		#email: @member.email } 
  																																	  emergency_contact_attributes: { 
  																																		name: @member.emergency_contact.name, 
  																																		relationship: @member.emergency_contact.relationship } } }
  	assert flash.empty?
  	assert_redirected_to root_url
  end

  test "ec controller should redirect update when not logged in" do
		patch emergency_contact_member_path(@member), params: { member: { #first_name: @member.first_name,
  																																		#last_name: @member.last_name,
  																																		#email: @member.email } 
  																																	  emergency_contact_attributes: { 
  																																		name: @member.emergency_contact.name, 
  																																		relationship: @member.emergency_contact.relationship } } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end