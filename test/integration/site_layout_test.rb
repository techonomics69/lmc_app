require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
	test "layout links" do
		get root_path
		assert_template 'static_pages/home'
		assert_select "a[href=?]", root_path, count:2
		assert_select "a[href=?]", 'http://leedsmc.org/bulletinboard/'
		assert_select "a[href=?]", membership_path
		assert_select "a[href=?]", '#'
		assert_select "a[href=?]", '#'
		assert_select "a[href=?]", '#'
		assert_select "a[href=?]", '#'
	end
end
