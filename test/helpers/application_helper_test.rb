require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	test "full title helper" do
		assert_equal full_title, "Leeds Mountaineering Club"
		assert_equal full_title("Help"), "Help | Leeds Mountaineering Club"
		assert_equal full_title("Application Form"), "Application Form | Leeds Mountaineering Club"
		
	end
end