#test for the meets controller for meet leaders. The committee member meet functions are in committee_meets_controller_test.rb

require 'test_helper'

class MeetsControllerTest < ActionDispatch::IntegrationTest

	def setup
		@member = members(:climber)
		@future_meet = meets(:future_meet)
	end

	test "redirects when not logged in" do
		get meets_member_path(@member, params: { meet: { id: @future_meet.id } })
		assert_redirected_to login_url
	end
end
