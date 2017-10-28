class SessionsController < ApplicationController
  def new
  end

  def create
  	member = Member.find_by(email:params[:session][:email].downcase)
  	if member && member.authenticate(params[:session][:password])
  		log_in member
      redirect_back_or(member)
  	else
  		flash[:danger] = 'Invalid email/password combination'
  		redirect_to login_path
  	end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
