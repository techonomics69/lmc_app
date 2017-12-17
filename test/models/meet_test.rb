require 'test_helper'

class MeetTest < ActiveSupport::TestCase
	def setup
		@assigned_meet = meets(:assigned_meet)
		@non_assigned_meet = meets(:non_assigned_meet)
	end

	test "should be valid" do
		assert @assigned_meet.valid?
	end

	test "number of nights must be number or nil" do
		@assigned_meet.number_of_nights = "invalid"
		assert_not @assigned_meet.valid?
	end

	test "meet_type must be valid" do
		@assigned_meet.meet_type = "hutting meet"
		assert_not @assigned_meet.valid?
	end

	test "location must be valid" do
		@assigned_meet.location = "    "
		assert_not @assigned_meet.valid?
	end

	test "places must be integer" do
		@assigned_meet.places = "some"
		assert_not @assigned_meet.valid?
	end
end
