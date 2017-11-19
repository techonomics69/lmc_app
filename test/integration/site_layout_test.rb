require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

	def setup
		@member = members(:luke)
		@other_member = members(:climber)
	end

	test "layout links" do
		get root_path
		assert_template 'static_pages/home'
		assert_select "a[href=?]", root_path, count:2
		assert_select "a[href=?]", 'http://leedsmc.org/bulletinboard/'
		assert_select "a[href=?]", membership_path
		assert_select "a[href=?]", '#'
		assert_select "a[href=?]", '#'
		assert_select "a[href=?]", '#'
		assert_select "a[href=?]", '#'
	end

	test "member links" do
		log_in_as(@other_member)
		get member_path(@other_member)
		assert_select "a[href=?]", edit_member_path(@other_member)
		assert_select "a[href=?]", emergency_contact_member_path(@other_member)
		assert_select "a[href=?]", committee_members_path, count: 0
#		assert_select "a[href=?]", 'meets_path', count: 0
	end

		test "committee member links" do
			log_in_as(@member)
			get member_path(@member)
			assert_select "a[href=?]", edit_member_path(@member)
			assert_select "a[href=?]", emergency_contact_member_path(@member)
			assert_select "a[href=?]", committee_members_path
#			assert_select "a[href=?]", 'meets_path', count: 0
		end
end
