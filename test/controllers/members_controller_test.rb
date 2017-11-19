require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest

	def setup
		@member = members(:luke)
		@other_member = members(:climber)
	end

  test "should redirect all actions when not committee member" do
    log_in_as(@other_member)
    get committee_members_path
    assert_redirected_to membership_path
  end

  test "should get new" do
    get application_path
    assert_response :success
  end

  test "should redirect show when logged in as wrong member" do
    log_in_as(@other_member)
    get member_path(@member)
    assert flash.empty?
    assert_redirected_to root_url
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

  test "should redirect show when not logged in" do
    get member_path(@member)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch member_path(@member), params: { member: { first_name: @member.first_name,
                                                    last_name: @member.last_name,
                                                    email: @member.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not allow the committee_position attribute to be edited via the web" do
    log_in_as(@other_member)
    assert_not @other_member.membership.committee_position?
    patch member_path(@other_member), params: { member: { password: "",
                                                    password_confirmation: "", } }
                                              { membership: { committee_position: "Chairperson" } }
    assert_not @other_member.reload.membership.committee_position?
  end
end
