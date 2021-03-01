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
		assert_select "a[href=?]", committee_meet_path(@committee_member), count: 0
		assert_select "a[href=?]", edit_role_committee_members_path, count: 0
		assert_select "a[href=?]", emergency_contact_member_path, count: 1
		assert_select "a[href=?]", edit_member_path(@normal_member), count: 1

		get committee_members_path(@normal_member)
		assert_redirected_to membership_path

		get committee_meet_path(@committee_member)
		assert_redirected_to membership_path

		edit_role_committee_members_path
		assert_redirected_to membership_path

		get edit_committee_member_path(@committee_member)
		assert_redirected_to membership_path
	end

	test "all links are available to committee members" do
		log_in_as(@committee_member)
		get member_path(@committee_member)
		assert_select "a[href=?]", committee_members_path, count:1
		assert_select "a[href=?]", committee_meets_path, count: 1
		assert_select "a[href=?]", edit_role_committee_members_path, count: 1
		assert_select "a[href=?]", edit_member_path(@committee_member), count: 1
		assert_select "a[href=?]", emergency_contact_member_path, count: 1
#		assert_select "a[href=?]", meets_member_path(@committee_member, params: {"meet"=> {"id"=> @assigned_meet.id } } ), count:1
	end

	test "meets are not available to non leaders" do
		log_in_as(@normal_member)
		get member_path(@normal_member)
		meets = Meet.all
		meets.each do |m|
			assert_select "a[href=?]", meets_member_path(@committee_member, params: {"meet"=>{"id"=>m.id}}), count:0
		end
	end
end
