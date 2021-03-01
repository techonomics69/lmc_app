require 'test_helper'

class MeetsEditTest < ActionDispatch::IntegrationTest	

  def setup
		@meet_leader = members(:luke)
		@member = members(:climber)
		@meet = meets(:future_meet)
	end

	test "meet leader can edit meet notes, bb_url, location and opens on" do
		log_in_as(@meet_leader)
		assert is_logged_in?
    patch meets_member_path(@meet_leader), params: {
			meet: { 
				location: "somewhere else",
				notes: "some new notes",
				bb_url: "the bb url",
				opens_on: Date.yesterday,
				id: @meet.id
			}
		}
		# member must equal meet_leader. meet_leader is found by meet.attendees. Attendees doesn't exist in fixtures. Work out how to add fixtures for table joins.
		assert_redirected_to meets_member_path(@meet_leader.id, {:meet => {:id => @meet.id}})
    @meet.reload
    assert_equal @meet.notes, "some new notes"
		assert @meet.bb_url == "the bb url"
		assert @meet.location == "somewhere else"
		assert @meet.opens_on == Date.yesterday
	end

	test "meet cannot be edited by non meet leader" do
		log_in_as(@member)
  	get meets_member_path(@member, params: { meet: { id: @meet.id } })
  	assert_redirected_to membership_path
  	patch meets_member_path(@member), params: { meet: { notes: "notes",
                                                    		bb_url: "bb url",
                                                    		id: @meet.id } }
  	@meet.reload
    assert_not_equal(@meet.notes, "notes")
    assert_not_equal(@meet.bb_url, "bb url")
	end

end