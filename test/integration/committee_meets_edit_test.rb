require 'test_helper'

class CommitteeMeetsEditTest < ActionDispatch::IntegrationTest

	def setup
		@committee_member = members(:luke)
		@normal_member = members(:climber)
		@assigned_meet = meets(:assigned_meet)
		@non_assigned_meet = meets(:non_assigned_meet)
	end

	test "successful edit" do
		log_in_as(@committee_member)
    patch committee_meet_path(@non_assigned_meet), params: { meet: { 
            														meet_date: Date.strptime('01-02-2018', '%d-%m-%Y'),
            														member_id: @normal_member.id,
            														location: "New location",
            														meet_type: "Hut",
            														number_of_nights: 2,
            														places: 12,
            														notes: "notes",
                                        bb_url: "bb url" } }
    @non_assigned_meet.reload
    assert @non_assigned_meet.meet_date == Date.strptime('01-02-2018', '%d-%m-%Y')
    assert @non_assigned_meet.member_id == @normal_member.id 
    assert @non_assigned_meet.location == "New location"
    assert @non_assigned_meet.meet_type == "Hut"
    assert @non_assigned_meet.number_of_nights == 2
    assert @non_assigned_meet.places == 12
    assert @non_assigned_meet.notes == "notes"
    assert @non_assigned_meet.bb_url == "bb url"
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_not flash.empty?
	end

	test "unsuccessful edit" do
		log_in_as(@committee_member)
    patch committee_meet_path(@non_assigned_meet), params: { meet: { 
    																										meet_date: "invalid",
    																										member_id: "no id",
    																										location: "  ",
    																										meet_type: "invalid",
    																										number_of_nights: "invalid",
    																										places: "none",
    																										notes: " ",
                                                    		bb_url: " " } }
    @non_assigned_meet.reload
    assert_not_equal(@non_assigned_meet.meet_date, "invalid")
    assert_not_equal(@non_assigned_meet.member_id, "no id")
    assert_not_equal(@assigned_meet.location, "  ")
    assert_not_equal(@non_assigned_meet.meet_type, "invalid")
    assert_not_equal(@non_assigned_meet.number_of_nights, "invalid")
    assert_not_equal(@non_assigned_meet.places, "none")
    assert_not_equal(@non_assigned_meet.notes, " ")
    assert_not_equal(@non_assigned_meet.bb_url, " ")
    assert_template 'committee/meets/edit'
		assert_select "p#error_explanation", 9
	end
end