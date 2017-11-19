require 'test_helper'

class CommitteeIndexTest < ActionDispatch::IntegrationTest

	def setup
		@committee_member = members(:luke)
		@normal_member = members(:climber)
	end

	test "view, edit and delete links are available and working" do
		log_in_as(@committee_member)
		get committee_members_path(@committee_member)
		assert_template 'committee/members/index'
		member = Member.all
		member.each do |m|
			assert_select 'a[href=?]', committee_member_path(m), text: 'view'
			assert_select 'a[href=?]', edit_committee_member_path(m), text: 'edit'
			assert_select 'a[href=?]', committee_member_path(m), text: 'delete'
		end
		assert_difference 'Member.count', -1 do
			delete committee_member_path(@normal_member)
		end
	end

end
