require 'test_helper'

class CommitteeEditTest < ActionDispatch::IntegrationTest

	def setup
		@committee_member = members(:luke)
		@normal_member = members(:climber)
	end

	test "unsuccessful single edit" do
		log_in_as(@committee_member)
		get edit_committee_member_path(@normal_member)
		assert_template 'committee/members/edit'
		patch committee_member_path(@normal_member), params: { member: { 
																									first_name: "",
																								  last_name: "",
																								  address_1: "",
																								  address_2: "",
																								  address_3: "",
																								  town: "",
																								  postcode: "",
																								  country: "",
																								  phone: "",
																								  email: "invalidexample",
																								  dob: "",
																								  } }
																								  { membership: {
																								  	  membership_type: "Provisional",
																											welcome_pack_sent: "False",
																											fees_received_on: "",
																											bmc_number: "",
																											notes: ""} }
		assert_template 'committee/members/edit'
		assert_select 'div.field_with_errors'
		assert_select 'p#error_explanation'
	end

	test "successful single edit" do
		get committee_members_path(@committee_member)
		assert_equal session[:forwarding_url], committee_members_url(@committee_member)
		log_in_as(@committee_member)
		assert_redirected_to committee_members_path(@committee_member)
		get edit_committee_member_path(@normal_member)
		address_1 = "Foo"
		town = "Bar"
		email = "foo@bar.com"
		membership_type = "Honorary"
		fees_received_on = "01/01/1998"
		patch committee_member_path(@normal_member), params: { member: { 
																								  address_1: address_1,
																								  address_2: "jgd",
																								  address_3: "jfudyd",
																								  town: town,
																								  postcode: "BD1 6PR",
																								  country: "United Kingdom",
																								  phone: "01234567890",
																								  email: email,
																								  dob: "08/07/2001",
																								  membership_attributes: {
																								  	  membership_type: membership_type,
																											welcome_pack_sent: "True",
																											fees_received_on: fees_received_on,
																											bmc_number: "01235456",
																											notes: "sgs"} } }
		assert_not flash.empty?
		assert_redirected_to committee_members_path
		@normal_member.reload
		assert_equal address_1, @normal_member.address_1
		assert_equal town, @normal_member.town
		assert_equal email, @normal_member.email
		assert_equal membership_type, @normal_member.membership.membership_type
		assert_equal fees_received_on, @normal_member.membership.fees_received_on.strftime("%d/%m/%Y")
	end

	test "unsuccessful multiple edit" do
		log_in_as(@committee_member)
		post multiple_committee_members_path, params: { selected: [], route_to: {'edit'=>''} }
		assert_redirected_to committee_members_path
		follow_redirect!
		assert_template 'committee/members/index'
		assert_not flash.empty?
		post multiple_committee_members_path, params: { selected: [@normal_member.id,@committee_member.id], route_to: {'edit'=>''} }
		assert_template 'committee/members/multiple'
		patch update_multiple_committee_members_path, params: { member_ids: [@normal_member.id,@committee_member.id],
																								  	  membership: {
																								  	  membership_type: "Unknown",
																											welcome_pack_sent: "Invalid",
																											fees_received_on: "Invalid"
																											 } }
		assert_redirected_to committee_members_path
		assert_not flash.empty?
	end

	test "successful multiple edit" do
		log_in_as(@committee_member)
		post multiple_committee_members_path, params: { selected: [@normal_member.id,@committee_member.id], route_to: {'edit'=>''} }
		assert_template 'committee/members/multiple'
		membership_type = "Full"
		welcome_pack_sent = true
		fees_received_on = "01/01/2017"
		patch update_multiple_committee_members_path, params: { member_ids: [@normal_member.id,@committee_member.id],
																								  	  membership: {
																								  	  membership_type: membership_type,
																											welcome_pack_sent: welcome_pack_sent,
																											fees_received_on: fees_received_on
																											 } }
		assert_redirected_to committee_members_path
		assert_not flash.empty?
		@normal_member.reload
		assert_equal membership_type, @normal_member.membership.membership_type
		assert_equal welcome_pack_sent, @normal_member.membership.welcome_pack_sent
		assert_equal fees_received_on, @normal_member.membership.fees_received_on.strftime("%d/%m/%Y")
		assert_equal membership_type, @committee_member.membership.membership_type
		assert_equal welcome_pack_sent, @committee_member.membership.welcome_pack_sent
		assert_equal fees_received_on, @committee_member.membership.fees_received_on.strftime("%d/%m/%Y")
	end

end
