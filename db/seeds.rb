# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

member = Member.create!(first_name: "Chris",
							 last_name: "Bonnington",
							 address_1: "1 Top Road",
							 address_2:"",
							 address_3:"",
							 town: "Everest",
							 postcode: "EV1 1ST",
							 country:"United Kingdom",
							 phone: "01234567891",
							 email: "chris@example.com",
							 dob: DateTime.new(1934,8,06).strftime,
							 experience: "I've climbed a few mountains in my time",
							 accept_risks: true,
							 password: "password",
							 password_confirmation: "password")

member.membership.update(
							 	bmc_number: "",
							 	membership_type: "Full",
							 	fees_received_on: DateTime.new(2017,1,1).strftime,
							 	welcome_pack_sent: true,
							 	made_full_member: DateTime.new(1967,7,9).strftime,
							 	committee_position: "Treasurer",
							 	subs_paid: true,
							 	notes: "Pretty good mountaineer")

member = Member.create!(first_name: "Mark",
							 last_name: "Example 1",
							 address_1: "99 Road Name",
							 address_2:"",
							 address_3:"",
							 town: "Leeds",
							 postcode: "LS1 1AB",
							 country:"United Kingdom",
							 phone: "01234567898",
							 email: "mark@example.com",
							 dob: DateTime.new(1980,4,2).strftime,
							 experience: "Done some climbing",
							 accept_risks: true,
							 password: "password",
							 password_confirmation: "password")

member.membership.update(
							 	bmc_number: "",
							 	membership_type: "Full",
							 	fees_received_on: DateTime.new(2017,1,8).strftime,
							 	welcome_pack_sent: true,
							 	made_full_member: DateTime.new(2014,3,12).strftime,
							 	committee_position: "Chair",
							 	subs_paid: true,
							 	notes: "")

Member.create!(first_name: "Luke",
							 last_name: "Example 2",
							 address_1: "11 Street",
							 address_2:"",
							 address_3:"",
							 town: "Leeds",
							 postcode: "LS19 9QR",
							 country:"United Kingdom",
							 phone: "01234567894",
							 email: "luke@example.com",
							 dob: DateTime.new(1987,12,8).strftime,
							 experience: "Climbing stuff",
							 accept_risks: true,
							 password: "password",
							 password_confirmation: "password")

member.membership.update(
							 	bmc_number: "",
							 	membership_type: "Full",
							 	fees_received_on: DateTime.new(2017,1,10).strftime,
							 	welcome_pack_sent: true,
							 	made_full_member: DateTime.new(2015,2,11).strftime,
							 	committee_position: "Membership Secretary",
							 	subs_paid: true,
							 	notes: "")

60.times do |n|
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	address_1 = Faker::Address.street_address
	town = Faker::Address.city
	postcode = "LS#{n+7} #{n+3}MC"
	phone = Faker::Number.number(11)
	email = "member-#{n+1}@example.com"
	dob = Faker::Date.between(60.years.ago, 20.years.ago).strftime
	password = "password"
	experience = Faker::StarWars.quote

	fees = Faker::Date.between(3.years.ago, Date.today).strftime
	wps = Faker::Boolean.boolean
	mfm = fees = Faker::Date.between(20.years.ago, Date.today).strftime

	rel_gen = Faker::Number.number(5)
	case rel_gen
	when 0
		relationship = "Father"
	when 1
		relationship = "Mother"
	when 2
		relationship = "Brother"
	when 3
		relationship = "Sister"
	when 4
		relationship = "Aunt"
	when 5
		relationship = "Uncle"
	else
		relationship = "Friend"
	end

	ec_name = Faker::Name.name
	ec_ad_1 = Faker::Address.street_address
	ec_town = Faker::Address.city
	ec_postcode = "EC#{n+2} #{n+7}PL"
	ec_ph_1 = Faker::Number.number(11)
member =	Member.create!(first_name: first_name,
							 last_name: last_name,
							 address_1: address_1,
							 address_2:"",
							 address_3:"",
							 town: town,
							 postcode: postcode,
							 country:"United Kingdom",
							 phone: phone,
							 email: email,
							 dob: dob,
							 experience: experience,
							 accept_risks: true,
							 password: "password",
							 password_confirmation: "password")

member.membership.update(
							 	bmc_number: "",
							 	membership_type: "Provisional (unpaid)",
							 	fees_received_on: fees,
							 	welcome_pack_sent: wps,
							 	made_full_member: mfm,
							 	notes: "")

member.emergency_contact.update(
							 	name: ec_name,
							 	address_1: ec_ad_1,
							 	address_2:"",
							 	address_3:"",
							 	town: ec_town,
							 	postcode: ec_postcode,
							 	country: "United Kingdom",
							 	primary_phone: ec_ph_1,
							 	secondary_phone: "",
							 	relationship: relationship)
end