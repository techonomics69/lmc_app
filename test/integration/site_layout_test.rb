require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

	def setup
		@member = members(:luke)
		@other_member = members(:climber)
	end

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

	test "meets calendar is displayed on home page" do
		get root_path
		future_meets = Meet.where('meet_date >= ?', Date.today).all.order(:meet_date)
		number = future_meets.count
		assert_select 'tr', count: number+1
		future_meets.each do |m|
			css = m.meet_type.downcase
			assert_select 'tr.'"#{css}"'-meet'
		end
	end
end
