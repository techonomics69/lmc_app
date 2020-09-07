# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


#!!!!! remember to run: rails db:fixtures:load RAILS_ENV=test after resetting the database!!!!!!!

member = Member.create!(
							 first_name: "Chris",
							 last_name: "Bonnington",
							 address_1: "1 Top Road",
							 address_2:"",
							 address_3:"",
							 town: "Everest",
							 postcode: "EV1 1ST",
							 county: "Himalayas",
							 country:"United Kingdom",
							 home_phone: "01234567891",
							 mob_phone: "09876543212",
							 email: "chris@example.com",
							 dob: DateTime.new(1934,8,06).strftime,
							 experience: "I've climbed a few mountains in my time",
							 accept_risks: true,
							 receive_emails: true,
							 password: "password",
							 password_confirmation: "password")

member.membership.update(
							 	bmc_number: "",
							 	membership_type: "Full",
							 	fees_received_on: DateTime.new(2017,1,1).strftime,
							 	welcome_pack_sent: true,
							 	made_full_member: DateTime.new(1967,7,9).strftime,
							 	subs_paid: true,
							 	notes: "Pretty good mountaineer")

member = Member.create!(
							 first_name: "Mark",
							 last_name: "Example 1",
							 address_1: "99 Road Name",
							 address_2:"",
							 address_3:"",
							 town: "Leeds",
							 county: "West Yorkshire",
							 country:"United Kingdom",
							 postcode: "LS1 1AB",
							 mob_phone: "01234567898",
							 email: "mark@example.com",
							 dob: DateTime.new(1980,4,2).strftime,
							 experience: "Done some climbing",
							 accept_risks: true,
							 receive_emails: true,
							 password: "password",
							 password_confirmation: "password")

member.membership.update(
							 	bmc_number: "",
							 	membership_type: "Full",
							 	fees_received_on: DateTime.new(2017,1,8).strftime,
							 	welcome_pack_sent: true,
							 	made_full_member: DateTime.new(2014,3,12).strftime,
							 	committee_position: "Social Secretary",
							 	subs_paid: true,
							 	notes: "")

member = Member.create!(
							 first_name: "Luke",
							 last_name: "Example 2",
							 address_1: "11 Street",
							 address_2:"",
							 address_3:"",
							 town: "Leeds",
							 postcode: "LS19 9QR",
							 county: "West Yorkshire",
							 country:"United Kingdom",
							 home_phone: "01234567894",
							 email: "luke@example.com",
							 dob: DateTime.new(1987,12,8).strftime,
							 experience: "Climbing stuff",
							 accept_risks: true,
							 receive_emails: true,
							 password: "password",
							 password_confirmation: "password")

member.membership.update(
							 	bmc_number: "",
							 	membership_type: "Full",
							 	fees_received_on: DateTime.new(2020,1,10).strftime,
							 	welcome_pack_sent: true,
							 	made_full_member: DateTime.new(2017,2,11).strftime,
							 	committee_position: "Membership Secretary",
							 	subs_paid: true,
							 	notes: "")

60.times do |n|
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	address_1 = Faker::Address.street_address
	town = Faker::Address.city
	postcode = "LS#{n+7} #{n+3}MC"
	home_phone = Faker::Number.number(11)
	mob_phone = Faker::Number.number(11)
	email = "member-#{n+1}@example.com"
	dob = Faker::Date.between(60.years.ago, 20.years.ago).strftime
	password = "password"
	experience = Faker::StarWars.quote

	fees = Faker::Date.between(4.years.ago, Date.today).strftime
	wps = Faker::Boolean.boolean
	mfm = fees = Faker::Date.between(20.years.ago, Date.today).strftime

	rel_gen = Faker::Number.number(1).to_i
	case rel_gen
	when 0, 1
		relationship = "Father"
		membership_type = "Provisional (unpaid)"
		county = "West Yorkshire"
	when 2, 3
		relationship = "Mother"
		membership_type ="Provisional"
		county = "Lancashire"
	when 4, 5
		relationship = "Brother"
		membership_type = "Full"
		county = "Cumbria"
	when 6
		relationship = "Sister"
		membership_type = "Full"
		county = "West Yorkshire"
	when 7
		relationship = "Aunt"
		membership_type = "Provisional"
		county = "East Yorkshire"
	when 8
		relationship = "Uncle"
		membership_type = "Full"
		county = "North Yorkshire"
	else
		relationship = "Friend"
		membership_type = "Honorary"
		county = "South Yorkshire"
	end

	ec_name = Faker::Name.name
	ec_ad_1 = Faker::Address.street_address
	ec_town = Faker::Address.city
	ec_postcode = "EC#{n+2} #{n+7}PL"
	ec_ph_1 = Faker::Number.number(11)
	member =	Member.create!(
							 first_name: first_name,
							 last_name: last_name,
							 address_1: address_1,
							 address_2:"",
							 address_3:"",
							 town: town,
							 county: county,
							 postcode: postcode,
							 country:"United Kingdom",
							 home_phone: home_phone,
							 mob_phone: mob_phone,
							 email: email,
							 dob: dob,
							 experience: experience,
							 accept_risks: true,
							 receive_emails: false,
							 password: "password",
							 password_confirmation: "password")

	member.membership.update(
							 	bmc_number: "",
							 	membership_type: membership_type,
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
members = []
8.times do |n|
	members << Member.find_by(email:"member-#{n+1}@example.com")
end

remaining_committee = ["Chair",
						 					 "Treasurer",
						  				 "Meets Secretary",
						 					 "Communications Secretary",
						 					 "Climbing Co-ordinator",
						 					 "Walking Co-ordinator",
						 					 "Ordinary Member",
						 					 "Member Without Portfolio"]
n = 0
members.each do |member|
	member.membership.update(committee_position: remaining_committee[n])
	n += 1
end

#Meet1
Meet.create!( meet_date: DateTime.new(2020,8,10),
							meet_type: "Hut",
							number_of_nights: 2,
							places: 12,
							location: "Ingleton, Yorkshire Dales",
							bb_url: "www.bburl2.com")
#Meet2
Meet.create!( meet_date: DateTime.new(2020,7,22),
							meet_type: "Camping",
							number_of_nights: 2,
							location: "Ty'n Lon, Nant Peris, Snowdonia",
							bb_url: "www.bburl12.com",
							notes: "some notes")
#Meet3
Meet.create!( meet_date: DateTime.new(2020,5,3),
							meet_type: "Camping",
							number_of_nights: 2,
							location: "Gwern Gof Uchaf Campsite, Ogwen, Wales",
							bb_url: "www.bburl.com")
#Meet4
Meet.create!( meet_date: DateTime.new(2020,6,4),
							meet_type: "Evening",
							location: "Leeds Wall",
  						activity: "climb")
#Meet5
Meet.create!( meet_date: DateTime.new(2020,6,4),
							meet_type: "Day",
							location: "Pen y Ghent, Yorkshire Dates",
							bb_url: "www.bburl4.com",
							notes: "Meet at Horton in Ribblesdale at 10am",
  						activity: "walk")
#Meet6
Meet.create!( meet_date: DateTime.new(2020,11,9),
							meet_type: "Hut",
							number_of_nights: 2,
							places: 16,
							location: "K Shoes, Borrowdale")
#Meet7
Meet.create!( meet_date: DateTime.new(2020,6,9),
							meet_type: "Hut",
							number_of_nights: 4,
							places: 10,
							location: "Kinlochewe Hotel Bunkhouse, nr. Torridon, Northwest Highlands, Scotland")

#Meet 1
Attendee.create!( member_id: 3,
									meet_id: 1,
									is_meet_leader: true,
									paid: true,
									sign_up_date: Date.today)
									
Attendee.create!( member_id: 5,
									meet_id: 1,
									is_meet_leader: false,
									paid: false,
									sign_up_date: Date.today)

Attendee.create!( member_id: 7,
									meet_id: 1,
									is_meet_leader: false,
									paid: false,
									sign_up_date: Date.today)

Attendee.create!( member_id: 24,
									meet_id: 1,
									is_meet_leader: false,
									paid: true,
									sign_up_date: Date.today)

#Meet 2
Attendee.create!( member_id: 3,
									meet_id: 2,
									is_meet_leader: true,
									paid: true,
									sign_up_date: Date.today)
									
Attendee.create!( member_id: 10,
									meet_id: 2,
									is_meet_leader: false,
									paid: false,
									sign_up_date: Date.today)

#Meet 4
Attendee.create!( member_id: 6,
									meet_id: 4,
									is_meet_leader: false,
									paid: false,
									sign_up_date: Date.today)
									
Attendee.create!( member_id: 5,
									meet_id: 4,
									is_meet_leader: true,
									paid: true,
									sign_up_date: Date.today)

Email.create!(template: "newsfeed",
							subject: "Newsfeed Template",
							body: "<p>This is the newsfeed template</p>",
							default_template: true)

Email.create!(template: "subs reminder",
							subject: "Subs Reminder Template",
							body: "<p>This is the subs reminder template</p>",
							default_template: true)

Email.create!(template: "welcome",
							subject: "Welcome to the Leeds Mountaineering Club",
							body: "<p>This is the welcome email</p>",
							default_template: true)