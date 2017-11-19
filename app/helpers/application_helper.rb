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

	def sort_link(column, title = nil)
#		title ||= column.titleize
#		css_class = column == sort_column ? "sortable both #{sort_direction}" : nil
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		icon = sort_direction == "asc" ? "glyphicon glyphicon-chevron-up" : "glyphicon glyphicon-chevron-down"
		icon = column == sort_column ? icon : "glyphicon glyphicon-none"
		link_to "#{title} <span class='#{icon}'></span>".html_safe, committee_members_path(sort: column, direction: direction), method: :get
	end

	def readable_boolean(value)
		return "&#10004;" if value ==true
		"&#10008;"
	end
end
