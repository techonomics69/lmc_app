require 'test_helper'

class MeetTest < ActiveSupport::TestCase
	def setup
		@future_meet = meets(:future_meet)
	end

	test "should be valid" do
		assert @future_meet.valid?
	end

	test "number of nights must be number or nil" do
		@future_meet.number_of_nights = "invalid"
		assert_not @future_meet.valid?
	end

	test "meet_type must be valid" do
		@future_meet.meet_type = "hutting meet"
		assert_not @future_meet.valid?
	end

	test "location must be valid" do
		@future_meet.location = "    "
		assert_not @future_meet.valid?
	end

	test "places must be integer" do
		@future_meet.places = "some"
		assert_not @future_meet.valid?
	end
end
