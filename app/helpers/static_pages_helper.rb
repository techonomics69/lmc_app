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

end
