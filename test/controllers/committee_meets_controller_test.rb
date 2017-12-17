require 'test_helper'

class Committee::MeetsControllerTest < ActionDispatch::IntegrationTest
	def setup
		@committee_member = members(:luke)
		@normal_member = members(:climber)
		@assigned_meet = meets(:assigned_meet)
		@non_assigned_meet = meets(:non_assigned_meet)
	end

	test "committee members can create new meets" do
		log_in_as(@committee_member)
		get new_committee_meet_path
		post committee_meets_path, params: { meet: {meet_date: 2018-01-19,
  																	member_id: @normal_member.id,
  																	location: "Wales",
  																	bb_url: "www.bburl.com",
  																	meet_type: "Hut",
  																	number_of_nights: "2",
  																	places: "12",
  																	notes: "some notes"} }
		assert_response :redirect
		follow_redirect!
		assert_response :success
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference 'Meet.count' do
    	delete committee_meet_path(@assigned_meet)
    end
    assert_response :redirect
		follow_redirect!
		assert_response :success
	end

	test "should redirect destroy when logged in as a non committee member" do
		log_in_as(@normal_member)
		assert_no_difference 'Meet.count' do
    	delete committee_meet_path(@assigned_meet)
    end
    assert_response :redirect
		follow_redirect!
		assert_template 'static_pages/membership'
	end

	test "committee members can destroy meets" do
		log_in_as(@committee_member)
		assert_difference('Meet.count', -1) do
    	delete committee_meet_path(@assigned_meet)
    end
    assert_response :redirect
    follow_redirect!
    assert_template 'committee/meets/_meets_table'
    assert flash[:success] = "Meet deleted."
	end
end