require 'test_helper'

class CommitteeIndexTest < ActionDispatch::IntegrationTest

	def setup
		@committee_member = members(:luke)
		@normal_member = members(:climber)
	end

	test "unsuccessful role assign for non committee member" do
		committee_position = "Treasurer"
		log_in_as(@normal_member)
		get edit_role_committee_members_path
		follow_redirect!
		assert_template 'static_pages/membership'
		patch update_role_committee_members_path, params: { id: @normal_member.id,
																								  	  membership: {
																								  	  committee_position: committee_position
																											 } }
		@normal_member.reload
		assert_not_equal committee_position, @normal_member.membership.committee_position
	end

	test "unsuccessful role assign" do
		committee_position = "foobar"
		log_in_as(@committee_member)
		get edit_role_committee_members_path
		patch update_role_committee_members_path, params: { id: @normal_member.id,
																								  	  membership: {
																								  	  committee_position: committee_position
																											 } }

		assert_not flash.empty?
		@normal_member.reload
		assert_not_equal committee_position, @normal_member.membership.committee_position
	end

	test "successful role assign" do
		committee_position = "Membership Secretary"
		log_in_as(@committee_member)
		get edit_role_committee_members_path
		assert_template 'committee/members/edit_role'
		patch update_role_committee_members_path, params: { id: @normal_member.id,
																								  	  membership: {
																								  	  committee_position: committee_position
																											 } }
		assert_redirected_to edit_role_committee_members_path
		assert_not flash.empty?
		@normal_member.reload
		assert_equal committee_position, @normal_member.membership.committee_position
	end

end
