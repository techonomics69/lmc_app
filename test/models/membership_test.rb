require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
	def setup
		@membership = Membership.new(member_id: 1
																 membership_type: "Full",
																 welcome_pack_sent: true,
																 fees_received_on: "01-01-2017",
																 made_full_member: "05-06-2010",
																 notes: "some notes"
																 )
	end

	#test "should be valid" do
	#	assert @membership.valid?
	#end

	#test "membership_type should be Full, Provisional, Honorary, Lapsed" do
	#	@membership.membership_type = "Full"
	#	assert_not @membership.valid?
	#end

end
