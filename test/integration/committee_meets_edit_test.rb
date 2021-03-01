require 'test_helper'

class CommitteeMeetsEditTest < ActionDispatch::IntegrationTest

	def setup
		@committee_member = members(:luke)
		@normal_member = members(:climber)
		@future_meet = meets(:future_meet)
	end

	test "successful edit" do
		log_in_as(@committee_member)
    patch committee_meet_path(@future_meet), params: {
			meet: { 
				meet_date: Date.strptime('08-01-2021', '%d-%m-%Y'),
      	location: "New location",
      	meet_type: "Hut",
      	number_of_nights: 2,
        places: 12,
        notes: "notes",
        bb_url: "bb url",
				opens_on: Date.strptime('01-01-2021', '%d-%m-%Y') 
			},
			attendees: {
				member_id: 1
			}
		}
    @future_meet.reload
    assert @future_meet.meet_date == Date.strptime('08-01-2021', '%d-%m-%Y')
    assert @future_meet.location == "New location"
    assert @future_meet.meet_type == "Hut"
    assert @future_meet.number_of_nights == 2
    assert @future_meet.places == 12
    assert @future_meet.notes == "notes"
    assert @future_meet.bb_url == "bb url"
		assert @future_meet.opens_on == Date.strptime('01-01-2021', '%d-%m-%Y')
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_not flash.empty?
	end

	test "unsuccessful edit" do
		log_in_as(@committee_member)
    patch committee_meet_path(@future_meet), params: { 
			meet: { 
    		meet_date: Date.strptime('08-01-2021', '%d-%m-%Y'),
    		location: "  ",
    		meet_type: "invalid",
    		number_of_nights: "invalid",
    		places: "none",
    		notes: " ",
        bb_url: " ",
				opens_on: "invalid"
			},
			attendees: {
				member_id: 1
			}
		}
    @future_meet.reload
    assert_not_equal(@future_meet.meet_date, "invalid")
    assert_not_equal(@future_meet.location, "  ")
    assert_not_equal(@future_meet.meet_type, "invalid")
    assert_not_equal(@future_meet.number_of_nights, "invalid")
    assert_not_equal(@future_meet.places, "none")
    assert_not_equal(@future_meet.notes, " ")
    assert_not_equal(@future_meet.bb_url, " ")
		assert_not_equal(@future_meet.opens_on, "invalid")

    assert_template 'committee/meets/edit'
		assert_select "p#error_explanation", 9
	end
end