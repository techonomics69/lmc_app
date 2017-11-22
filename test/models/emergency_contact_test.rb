require 'test_helper'

class EmergencyContactTest < ActiveSupport::TestCase

	def setup
		@member = members(:climber)
	end

	test "should be valid" do
		assert @member.emergency_contact.valid?
	end

	test "name should be present" do
		@member.emergency_contact.name = "    "
		assert_not @member.emergency_contact.valid?
	end

	test "address_1 should be present" do
		@member.emergency_contact.address_1 = "     "
		assert_not @member.emergency_contact.valid?
	end

	test "each address line should not be too long" do
		@member.emergency_contact.address_1 = "a"*101
		@member.emergency_contact.address_2 = "a"*101
		@member.emergency_contact.address_3 = "a"*101
		assert_not @member.emergency_contact.valid?
	end

	test "town should be present" do
		@member.emergency_contact.town = "   "
		assert_not @member.emergency_contact.valid?
	end

	test "town should not be too long" do
		@member.emergency_contact.town = "a"*101
		assert_not @member.emergency_contact.valid?
	end

	test "postcode should be present" do
		@member.emergency_contact.postcode = "   "
		assert_not @member.emergency_contact.valid?
	end

	test "postcode should not be too long" do
		@member.emergency_contact.postcode = "a"*12
		assert_not @member.emergency_contact.valid?
	end

	test "country should be present" do
		@member.emergency_contact.country = "   "
		assert_not @member.emergency_contact.valid?
	end

	test "primary_phone should be present" do
		@member.emergency_contact.primary_phone = "    "
		assert_not @member.emergency_contact.valid?
	end

	test "relationship should be present" do
		@member.emergency_contact.relationship = "   "
		assert_not @member.emergency_contact.valid?
	end
end
