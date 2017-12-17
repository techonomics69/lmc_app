require 'test_helper'

class MeetsEditTest < ActionDispatch::IntegrationTest	

  def setup
		@meet_leader = members(:luke)
		@member = members(:climber)
		@assigned_meet = meets(:assigned_meet)
		@non_assigned_meet = meets(:non_assigned_meet)
	end

	test "meet leader can edit meet notes and bb_url" do
    log_in_as(@meet_leader)
    patch meets_member_path(@meet_leader), params: { meet: { notes: "notes",
                                                    		bb_url: "bb url",
                                                    		id: @assigned_meet.id } }
    @assigned_meet.reload
    assert @assigned_meet.notes == "notes"
    assert @assigned_meet.bb_url == "bb url"
	end

	test "meet cannot be edited by non meet leader" do
		log_in_as(@member)
  	get meets_member_path(@member, params: { meet: { id: @non_assigned_meet.id } })
  	assert_redirected_to membership_path
  	patch meets_member_path(@member), params: { meet: { notes: "notes",
                                                    		bb_url: "bb url",
                                                    		id: @non_assigned_meet.id } }
  	@assigned_meet.reload
    assert_not_equal(@assigned_meet.notes, "notes")
    assert_not_equal(@assigned_meet.bb_url, "bb url")
	end

end