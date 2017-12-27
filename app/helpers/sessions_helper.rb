module SessionsHelper

	def log_in(member)
		session[:member_id] = member.id
	end

	# Returns the user corresponding to the remember token cookie.
	def current_user
		@current_user ||= Member.find_by(id: session[:member_id])
	end

	# Returns true if the given user is the current user.
	def current_user?(member)
		member == current_user
	end

	def logged_in?
		!current_user.nil?
	end

	def log_out
		remove_exports if !session[:file].nil?
		reset_session
		@current_user = nil
	end

	def remove_exports
		path = session[:file]
		File.unlink(path) if File.exist?(path)
	end

	#redirects to stored location (or to the default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def saved_sort_or(default)
  	session[:forwarding_url] || default
  	session.delete(:forwarding_url)
  end
end
