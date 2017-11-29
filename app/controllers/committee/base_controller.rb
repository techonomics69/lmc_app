class Committee::BaseController < ApplicationController
  before_action :logged_in_member
	before_action :committee_member

	include MembersHelper
	
	private

	#before filters
		
	def committee_member
    if logged_in? #true when logged in
      @member = Member.find(session[:member_id])
      unless committee_member?(@member)
        flash[:danger] = "Restriced Access."
        redirect_to membership_path
      end
    else
      redirect_to root_url
    end
  end

  def remember_selected
    session[:members_to_edit] = params[:selected]
  end

  def recall_selected(members)
    if session[:members_to_edit]
      members.each { |m| m.selected = true if session[:members_to_edit].include?(m.id.to_s) }
    end
    session.delete(:members_to_edit)
  end

  def clear_selected(members)
    members.each { |m| m.selected = false }
    session.delete(:members_to_edit)
  end

  def saved_sort_or(default)
    session[:forwarding_url] || default
    session.delete(:forwarding_url)
  end
end