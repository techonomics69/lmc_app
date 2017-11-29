require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
	def setup
		@committee_member = members(:luke)
		@normal_member = members(:climber)
	end

	test "should be valid" do
		assert @committee_member.membership.valid?
	end

	test "membership_type should be Full, Provisional, Honorary, Provisional (unpaid)" do
		@committee_member.membership.membership_type = "   "
		assert_not @committee_member.membership.valid?
	end

	test "committee_position should be valid" do
		@committee_member.membership.committee_position = "Hut Secretary"
		assert_not @committee_member.membership.valid?
	end

	test "update_date_made_full" do
		assert @normal_member.membership.made_full_member == nil
		@normal_member.membership.membership_type = "Provisional"
		@normal_member.save
		@normal_member.membership.membership_type = "Full"
		@normal_member.save
		assert_not @normal_member.membership.made_full_member.nil?
	end

	test "update from provisional (unpaid)" do
		@normal_member.membership.membership_type = "Provisional (unpaid)"
		@normal_member.save
		assert @normal_member.membership.membership_type == "Provisional (unpaid)"
		@normal_member.membership.subs_paid = true
		@normal_member.save
		@normal_member.membership._run_find_callbacks
		assert @normal_member.membership.membership_type == "Provisional"
	end

	test "update_subs_paid when subs paid in same year" do
		@normal_member.membership.subs_paid = false
		assert @normal_member.membership.subs_paid == false
		@normal_member.membership.fees_received_on = DateTime.now
		@normal_member.save
		@normal_member.membership._run_find_callbacks
		assert @normal_member.membership.subs_paid == true
	end

	test "update subs paid when subs paid in Oct, Nov or Dec" do
		@normal_member.membership.subs_paid = false
		assert @normal_member.membership.subs_paid == false
		@normal_member.membership.fees_received_on = DateTime.new(2016,11,11)
		@normal_member.save
		@normal_member.membership._run_find_callbacks
		assert @normal_member.membership.subs_paid == true
	end

	test "update to honorary" do
		@normal_member.membership.subs_paid = false
		assert @normal_member.membership.subs_paid == false
		@normal_member.membership.membership_type = "Honorary"
		@normal_member.save
		@normal_member.membership._run_find_callbacks
		assert @normal_member.membership.subs_paid == true
	end

	test "committee_position can only be held by one member" do
		@committee_member.membership.committee_position = "Membership Secretary"
		@committee_member.save
		assert @committee_member.membership.committee_position == "Membership Secretary"
		@normal_member.membership.committee_position = "Membership Secretary"
		assert_not @normal_member.save
	end

end
