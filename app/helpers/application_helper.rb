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
end
