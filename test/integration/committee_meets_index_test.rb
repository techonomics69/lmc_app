require 'test_helper'

class CommitteeMeetsIndexTest < ActionDispatch::IntegrationTest

	def setup
		@committee_member = members(:luke)
		@normal_member = members(:climber)
		@future_meet = meets(:future_meet)
		@past_meet = meets(:past_meet)
	end

	test "edit and delete links are available and working" do
		log_in_as(@committee_member)
		get committee_meets_path
		assert_template 'committee/meets/index'
		future_meets = Meet.where('meet_date >= ?', Date.today).all.order(:meet_date)
		future_meets.each do |m|
			assert_select 'a[href=?]', edit_committee_meet_path(m), text: 'edit'
			assert_select 'a[href=?]', committee_meet_path(m), text: 'delete'
		end
		assert_difference 'Meet.count', -1 do
			delete committee_meet_path(@future_meet)
		end
	end

	test "view past meets displays past meets" do
		log_in_as(@committee_member)
		get committee_meets_path
		assert_select 'a[href=?]', committee_past_meets_path, count: 1
		get committee_past_meets_path
		assert_template partial: '_meets_table'
		past_meets = Meet.where('meet_date < ?', Date.today).all.order(meet_date: :desc)
		past_meets.each do |m|
			assert_select 'a[href=?]', edit_committee_meet_path(m), text: 'edit'
			assert_select 'a[href=?]', committee_meet_path(m), text: 'delete'
		end
		assert_difference 'Meet.count', -1 do
			delete committee_meet_path(@past_meet)
		end
	end

end