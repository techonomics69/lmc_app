class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :session_expires, if: :logged_in?
  before_action :update_session_time, if: :logged_in?

  def session_expires
    unless session[:expires_at].nil?
      time_left = session[:expires_at] - Time.now.to_i
      if time_left < 0
        log_out
        flash[:danger] = 'Logged out due to inactivity.'
        redirect_to login_url
      end
    end
  end

  def update_session_time
    if session[:expires_at].nil?
      session[:expires_at] = (Time.now + 20.minutes).to_i
    else
      time_left = session[:expires_at] - Time.now.to_i
      if time_left > 0
        session[:expires_at] = (Time.now + 20.minutes).to_i
      end
    end
  end

  private
    def logged_in_member
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_member
      @member = Member.find(params[:id])
      redirect_to(root_url) unless current_user?(@member)
    end
    
    def all_future_meets
      Meet.where('meet_date >= ?', Date.today).all.order(:meet_date)
    end

    def next_meets
      Meet.where('meet_date >= ?', Date.today).order(:meet_date).first(4)
    end

    def past_meets
      Meet.where('meet_date < ?', Date.today).all.order(meet_date: :desc)
    end

end
