module StaticPagesHelper

	def date_display(date, nights = 0)
		final_night = (date + nights.days)-1.days if !nights.nil?
		if nights.nil?
			return date.strftime("#{date.day.ordinalize} %b %Y")
		elsif date.month == final_night.month
			return date.strftime("#{date.day.ordinalize} ") + " - " + final_night.strftime("#{final_night.day.ordinalize} %b %Y")
		else
			date.strftime("#{date.day.ordinalize} %b ") + " - " + final_night.strftime("#{final_night.day.ordinalize} %b %Y")
		end
	end

	def ical_feed
  	meets = all_future_meets
  	@organiser = "mailto:leedsmc@gmail.com"
  	respond_to do |format|
  		format.html
  		format.ics do

		  	cal = Icalendar::Calendar.new
		  	filename = "icalfeed"
		  	cal.prodid = '-//LMC Meets Calendar//NONSGML v2.0//EN'
  			cal.version = '2.0'
  			filename += '.ics'

		  	meets.each do |m|

		  		case m.meet_type
		  		when "Hut"
		  			start_time = "T200000"
		  		when "Camping"
		  			start_time = "T200000"
		  		when "Evening"
		  			start_time = "T180000"
		  		when "Day"
		  			start_time = "T080000"
		  		end

		  		end_time = "T220000"
		  		start_date = m.meet_date.strftime("%Y%m%d") + start_time
		  		end_date = (m.meet_date + m.number_of_nights.to_i.days).strftime("%Y%m%d") + end_time

		  		meet_start = Icalendar::Values::DateTime.new(start_date)
		  		meet_end = Icalendar::Values::DateTime.new(end_date)

		  		event = Icalendar::Event.new
		  		event.dtstart = meet_start
		  		event.dtend = meet_end

		  		event.summary = "LMC #{m.meet_type.downcase} meet, #{m.location}. #{m.activity}."
		  		event.location = m.location
		  		event.organizer = @organiser
		  		if m.member.present?
		  			event.organizer = Icalendar::Values::CalAddress.new(@organiser, cn: "Meet Leader: #{m.member.first_name} #{m.member.last_name}")
		  		else
		  			event.organizer = Icalendar::Values::CalAddress.new(@organiser, cn: "Meet Leader: TBC")
		  		end
		  		cal.add_event(event)
		  	end

		  	cal.publish
		  	send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename
			end
		end
	end

end
