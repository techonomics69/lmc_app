require 'test_helper'

class Committee::MembersControllerTest < ActionDispatch::IntegrationTest
	def setup
		@committee_member = members(:luke)
		@normal_member = members(:climber)
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference 'Member.count' do
			delete committee_member_path(@normal_member)
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy when logged in as a non committee member" do
		log_in_as(@normal_member)
		assert_no_difference 'Member.count' do
			delete committee_member_path(@committee_member)
		end
		assert_redirected_to membership_path
	end
end