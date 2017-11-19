require 'test_helper'

class MembersShowTest < ActionDispatch::IntegrationTest

	def setup
		@committee_member = members(:luke)
		@normal_member = members(:climber)
	end

	test "committee paths are not available to non committee members and are redirected" do
		log_in_as(@normal_member)
		get member_path(@normal_member)
		assert_select "a[href=?]", committee_members_path, count:0
		assert_select "a[href=?]", emergency_contact_member_path
		assert_select "a[href=?]", edit_member_path(@normal_member), count: 1		
		get committee_members_path(@normal_member)
		assert_redirected_to membership_path
		get edit_committee_member_path(@committee_member)
		assert_redirected_to membership_path
	end

	test "committee paths are available to committee members" do
		log_in_as(@committee_member)
		get member_path(@committee_member)
		assert_select "a[href=?]", committee_members_path, count:1
#		assert_select "a[href=?]", '#', count: 2
		assert_select "a[href=?]", edit_member_path(@committee_member), count: 1
		get committee_members_path(@normal_member)
		assert_template 'committee/members/index'
	end

end
