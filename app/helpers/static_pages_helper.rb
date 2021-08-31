require 'open-uri'

module StaticPagesHelper
  def meta_description(page)
    case page
    when 'home'
      'A group of like minded people from the Leeds area and beyond who enjoy doing stuff in the outdoors including walking, climbing, mountaineering, mountain biking, cycling, skiing, camping and anything else that sounds like fun.'
    when 'benefits'
      'There are plenty of reasons to join the Leeds Mountaineering Club. We have a busy calendar of meets, organised social events, BMC affiliate membership and discounts with local shops and national retailers.'
    when 'booking'
      'How to book on a meet with the Leeds Mountaineering Club. You must be a member before you can come on a hut meet.'
    when 'calendar'
      "We have meets organized all over the country, throughout the year, camping and in huts. There's loads to do!"
    when 'contact'
      "Get in touch with the Leeds Mountaineering Club. We're happy to answer any questions about the club and how to join."
    when 'galleries'
      'See photos of some of our previous meets and adventures.'
    when 'handbook'
      'The rules and regulations which govern the club and how it works.'
    when 'help'
      'Information on joining the club, signing up for a meet, finding us and using this website.'
    when 'links'
      'A list of useful links for leeds based climber, walkers and mountaineers.'
    when 'meets'
      'On the first Tueday of every month we head to a pub for a pint and chat. We also climb every Tuesday, at the wall in winter and outside in summer. '
    when 'membership'
      'There are two levels of membership, provisional and full, you need to attend three meets and demonstrate that you can conduct yourself safely to progress from provisional to full membership.'
    when 'pay'
      'Pay your subs online with Paypal or contact us for other ways to pay.'
    when 'the_committee'
      'We have a 10 member committee who meet throughout the year to run the club. The committee are voted in every year at our AGM.'
    end
  end

  def bb_feed
    openuri_params = {
      open_timeout: 3,
      read_timeout: 3
    }
    begin
      content = open('http://bb.leedsmc.org/bbfeed.php', openuri_params).read
    rescue StandardError => e
      puts e
      'Timed out waiting for response from http://bb.leedsmc.org/bbfeed.php.'
    else
      page = Nokogiri::HTML(content)
      links = page.css('a')
      page.search('//br/preceding-sibling::text()|//br/following-sibling::text()').each_with_index do |node, i|
        node.replace(Nokogiri.make("<p>#{links[i]}<br>#{node.to_html}</p>"))
      end
      page.css('p').to_s
    end
  end

  def date_display(date, nights = 0)
    final_night = (date + nights.to_i) - 1.days
    if nights.nil? || nights == 0
      date.strftime("#{date.day.ordinalize} %b %Y")
    elsif date.month == final_night.month
      date.strftime("#{date.day.ordinalize} ") + ' - ' + final_night.strftime("#{final_night.day.ordinalize} %b %Y")
    else
      date.strftime("#{date.day.ordinalize} %b ") + ' - ' + final_night.strftime("#{final_night.day.ordinalize} %b %Y")
    end
  end

  def ical_feed
    meets = all_future_meets
    @organiser = 'mailto:leedsmc@gmail.com'
    respond_to do |format|
      format.html
      format.ics do
        cal = Icalendar::Calendar.new
        filename = 'lmc-meets-calendar'
        cal.prodid = '-//LMC Meets Calendar//NONSGML v2.0//EN'
        cal.version = '2.0'
        filename += '.ics'

        meets.each do |m|
          description = "LMC #{m.meet_type.downcase} meet, #{m.location}."

          case m.meet_type
          when 'Hut'
            start_time = 'T200000'
            description += " #{m.number_of_nights} nights, #{m.places} places."
          when 'Camping'
            start_time = 'T200000'
            description += " #{m.number_of_nights} nights."
          when 'Evening'
            start_time = 'T180000'
            description += " #{m.activity}ing meet." if m.activity.present?
          when 'Day'
            start_time = 'T080000'
            description += " #{m.activity}ing meet." if m.activity.present?
            end

          if m.member.present?
            description += " The meet leader is #{m.member.first_name + ' ' + m.member.last_name}."
       end
          description += " Notes: #{m.notes}." if m.notes.present?
          if m.bb_url.present?
            description += " More information at #{m.bb_url}."
           end

          summary = "LMC #{m.meet_type.downcase} meet, #{m.location}."
          summary += " #{m.activity}ing meet." if m.activity.present?

          end_time = 'T220000'
          start_date = m.meet_date.strftime('%Y%m%d') + start_time
          end_date = (m.meet_date + m.number_of_nights.to_i - 1.days).strftime('%Y%m%d') + end_time

          tzid = 'Europe/London'
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
            event.organizer = Icalendar::Values::CalAddress.new(@organiser, cn: 'Meet Leader: ' + meet_leader)
          else
            event.organizer = Icalendar::Values::CalAddress.new(@organiser, cn: 'Meet Leader: TBC')
            end
          cal.add_event(event)
        end

        cal.publish
        send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename
      end
    end
  end
end
