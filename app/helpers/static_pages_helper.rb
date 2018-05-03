module StaticPagesHelper

	def bb_feed
		begin
			page = Nokogiri::HTML(open('http://leedsmc.org/bbfeed.php'))
		rescue Exception
			return "BB Feed Error. No response from http://leedsmc.org/bbfeed.php."
			exit
		end
  	links = page.css('a')
		page.search("//br/preceding-sibling::text()|//br/following-sibling::text()").each_with_index do |node,i|
	    node.replace(Nokogiri.make("<p>#{links[i]}<br>#{node.to_html}</p>"))
	  end
  	page.css('p').to_s
	end

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

					description = "LMC #{m.meet_type.downcase} meet, #{m.location}."
		  		
		  		case m.meet_type
		  		when "Hut"
		  			start_time = "T200000"
		  			description += " #{m.number_of_nights} nights, #{m.places} places."
		  		when "Camping"
		  			start_time = "T200000"
		  			description += " #{m.number_of_nights} nights."
		  		when "Evening"
		  			start_time = "T180000"
		  			description += " #{m.activity}ing meet." if m.activity.present?
		  		when "Day"
		  			start_time = "T080000"
		  			description += " #{m.activity}ing meet." if m.activity.present?
		  		end

		  		description += " The meet leader is #{m.member.first_name + ' ' + m.member.last_name}." if m.member.present?
		  		description += " Notes: #{m.notes}." if m.notes.present?
		  		description += " More information at #{m.bb_url}." if m.bb_url.present?
						
					summary = "LMC #{m.meet_type.downcase} meet, #{m.location}."
					summary += " #{m.activity}ing meet." if m.activity.present?

		  		end_time = "T220000"
		  		start_date = m.meet_date.strftime("%Y%m%d") + start_time
		  		end_date = (m.meet_date + m.number_of_nights.to_i-1.days).strftime("%Y%m%d") + end_time

		  		tzid = "Europe/London"
		  		tz = TZInfo::Timezone.get tzid

		  		meet_start = Icalendar::Values::DateTime.new start_date, 'tzid' => tzid
		  		meet_end = Icalendar::Values::DateTime.new end_date, 'tzid' => tzid
					
					timezone = tz.ical_timezone meet_start
		  		cal.add_timezone timezone

		  		event = Icalendar::Event.new
		  		event.dtstart = meet_start
		  		event.dtend = meet_end
		  		event.description = description
		  		event.summary = summary
		  		event.location = m.location
		  		event.organizer = @organiser

		  		
		  		if m.member.present?
		  			meet_leader = m.member.first_name + ' ' + m.member.last_name
		  			event.organizer = Icalendar::Values::CalAddress.new(@organiser, cn: "Meet Leader: " + meet_leader)
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
