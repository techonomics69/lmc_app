module SessionsHelper

	def log_in(member)
		session[:member_id] = member.id
	end

	def current_user
		@current_user ||= Member.find_by(id: session[:member_id])
	end

	def current_user?(member)
		member == current_user
	end

	def logged_in?
		!current_user.nil?
	end

	def log_out
		session.delete(:member_id)
		@current_user = nil
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
end
