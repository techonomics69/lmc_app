require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest

	def setup
		@member = members(:test)
		@other_member = members(:climber)
	end

  test "should get new" do
    get application_path
    assert_response :success
  end

  test "should redirect edit when logged in as wrong member" do
  	log_in_as(@other_member)
  	get edit_member_path(@member)
  	assert flash.empty?
  	assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong member" do
  	log_in_as(@other_member)
  	patch member_path(@member), params: { member: { first_name: @member.first_name,
  																									last_name: @member.last_name,
  																									email: @member.email } }
  	assert flash.empty?
  	assert_redirected_to root_url
  end
end
