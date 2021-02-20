class AttendeesController < ApplicationController
  before_action :logged_in_member
  before_action :correct_member
  helper_method :format_date

  include MeetsHelper
  include ApplicationHelper

  def index
    @meets = all_future_meets
  end

  def new
    @member = Member.find(params[:id])
    @meet = Meet.find(params[:meet_id])
    @meet_leader = find_meet_leader(@meet)
    @attendees = @meet.attendees.where(is_meet_leader: false).order(sign_up_date: :asc)
    @member_is_on_meet = @member == @meet_leader || !@attendees.where(:member_id => @member.id).empty?
  end

  def create
    # if params[:attendee] is supplied then the request is coming from the committee meets edit page
    # if params[:attendee] is false then the request is coming from the member meet sign up page
    member_id = params[:attendee] ? params[:attendee][:member_id] : params[:id]
    paid = params[:attendee] ? params[:attendee][:paid] : false
    sign_up_date = params[:attendee] ? params[:attendee][:sign_up_date] : Date.today
    attendee = Attendee.create(
      meet_id: params[:meet_id],
      member_id: member_id,
      is_meet_leader: false,
      paid: paid,
      sign_up_date: sign_up_date
    )
    if !attendee.save
      flash[:danger] = 'Error adding meet attendee.'
    end
    if !attendee.errors.messages.empty?
      flash[:danger] = attendee.errors.full_messages.join(', ')
    end
    if params[:attendee]
      redirect_to meets_member_path(@member, {:meet => {:id => params[:meet_id]}})
    else
      redirect_to new_attendee_member_path(@member, {:meet => {:id => params[:meet_id]}})
    end
  end
end