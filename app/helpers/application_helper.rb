module ApplicationHelper
	def full_title(page_title = '')
		base_title = "Leeds Mountaineering Club"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end

	def show_errors(object, field, custom=nil)
		if object.errors.any?
			if custom
				custom
			elsif !object.errors.messages[field].blank?
				object.errors.messages[field][0]
			end
		end
	end

	def readable_boolean(value)
		value ? "&#10004;" : "&#10008;"
	end

	def sort_link(column, options = {})
		title = options[:title]
		link_path = options[:link_path]
		default = options[:default]
		store_sort
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		icon = sort_direction == "asc" ? "glyphicon glyphicon-chevron-up" : "glyphicon glyphicon-chevron-down"
		icon = column == sort_column ? icon : "glyphicon glyphicon-none"

		link_to "#{title} <span class='#{icon}'</span> ".html_safe, "#{link_path}?direction=#{direction}&sort=#{column}", method: :get
	end

  def store_sort
  	session[:forwarding_url] = request.original_url
  end

  def bb_url
  	"http://bb.leedsmc.org"
	end
	
	def format_date(date)
		date.strftime("%d/%m/%Y")
	end
end
