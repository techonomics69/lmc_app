module EmailsHelper

	def template
		case params[:template]
    when "newsfeed"
      Email.find_by_default_template_and_template(true, "newsfeed")
    when "reminder"
    	Email.find_by_default_template_and_template(true, "subs reminder")
    end
  end

  def recipients
  	case @email.template
  	when "newsfeed"
  		@recipients = Member.where('receive_emails = ?', true)
  	when "subs reminder"
  		@recipients = Member.joins(:membership).where("receive_emails = ? AND subs_paid = ?", true, false)
  	end
  end

  def no_send
  	return true if @email.default_template
  end


end
