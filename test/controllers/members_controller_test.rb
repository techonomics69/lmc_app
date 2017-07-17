require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get application_path
    assert_response :success
  end

end
