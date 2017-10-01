require 'test_helper'

class MembersSignupTest < ActionDispatch::IntegrationTest

	test "valid application information" do
		get application_path
		assert_difference 'Member.count', 1 do
			post members_path, params: { member: { first_name: "Example",
																					 last_name: "User",
																					 dob: "01/01/1990",
																					 experience: "some mountaineering",
																					 address_1: "1 Test Road",
																					 town: "testville",
																					 postcode: "TE51 1AA",
																					 country: "United Kingdom",
																					 email: "testuser@test.com",
																					 phone: "12345678901",
																					 accept_risks: true,
																					 password: "password",
																					 password_confirmation: "password" } }
		end

		follow_redirect!
		assert_template 'members/show'
		assert_not flash.empty?
		assert is_logged_in?
	end

	test "invalid application information" do
		get application_path
		assert_no_difference 'Member.count' do
			post members_path, params: { member: { first_name: "",
																						 email: "user@invalid",
																			 	 		 password: "foo",
																			  		 password_confirmation: "bar" } }
		end
		assert_template 'members/new'
		assert_select 'div#error_explanation'
		assert_select 'div.field_with_errors'
	end
end
