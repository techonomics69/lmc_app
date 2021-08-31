class AttendeesController < ApplicationController
  before_action :logged_in_member
  before_action :correct_member, except: :update_status
  before_action :meet_leader, only: %i[update destroy]
  before_action :meet_open?, only: %i[new create]

  helper_method :format_date

  include MeetsHelper
  include ApplicationHelper

  def index
    @meets = all_future_meets
  end

  def new
    @member = Member.find(params[:id])
    @meet = Meet.find(params[:meet_id])

    pending_attendees = @meet.attendees.where(status: 'pending').where('sign_up_date < ?', Date.yesterday)
    update_status(pending_attendees) unless pending_attendees.empty?

    @meet_leader = find_meet_leader(@meet)
    @attendees = @meet.attendees.where(is_meet_leader: false).order(sign_up_date: :asc)
    @member_is_on_meet = @member == @meet_leader || !@attendees.where(member_id: @member.id).empty?
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
      sign_up_date: sign_up_date,
      status: 'pending'
    )
    flash[:danger] = 'Error adding meet attendee.' unless attendee.save
    unless attendee.errors.messages.empty?
      flash[:danger] = attendee.errors.full_messages.join(', ')
    end
    if params[:attendee]
      redirect_to meets_member_path(@member, { meet: { id: params[:meet_id] } })
    else
      redirect_to new_attendee_member_path(@member, { meet: { id: params[:meet_id] } })
    end
  end

  def update
    @meet = Meet.find(meet_params[:id])
    attendee = Attendee.find(attendee_params[:id])
    update_paid(attendee) if attendee_params[:update_paid]
    update_meet_leader(attendee) if attendee_params[:update_meet_leader]

    redirect_to meets_member_path(@member, { meet: { id: @meet.id } })
  end

  def update_status(pending_attendees)
    @meet.attendees.where(is_meet_leader: true).update(status: 'confirmed')

    if !pending_attendees.nil? && !@meet.places.nil?
      run_status_update(pending_attendees)
    end
    redirect_to new_attendee_member_path(params[:member_id], { meet: { id: @meet.id } })
  end

  def destroy
    @meet = Meet.find(meet_params[:id])
    attendee = Attendee.find(attendee_params[:id])
    attendee.destroy
    redirect_to meets_member_path(@member, { meet: { id: @meet.id } })
  end

  private

  def run_status_update(pending_attendees)
    dates = pending_attendees.map(&:sign_up_date).uniq
    ballots = []
    dates.each do |date|
      attendees_by_date = pending_attendees.where(sign_up_date: date)
      if attendees_by_date.count + 1 > @meet.places
        ballots.push(attendees_by_date)
      end
    end
    # ballots = [[Attendee, Attendee], [Attendee, Attendee]]

    if !ballots.empty?
      # Run separate ballot for each group.
      ballots.each { |ballot| run_ballot(ballot) }
    else
      puts 'confirming...'
      yesterday_and_older_pending = pending_attendees.where('sign_up_date < ?', Date.today)
      yesterday_and_older_pending.update_all(status: 'confirmed')
    end
  end

  def update_paid(attendee)
    unless attendee.toggle!(:paid)
      flash[:danger] = 'Failed to update payment status.'
    end
  end

  def update_meet_leader(attendee)
    current_leader = find_meet_leader(@meet).attendees.where(meet_id: @meet.id).first
    unless attendee.toggle!(:is_meet_leader) && current_leader.update_attribute(:is_meet_leader, false) && attendee.update_attribute(:status, 'confirmed')
      flash[:danger] = 'Failed to update meet leader.'
    end
  end

  def meet_leader
    member = Member.find(params[:id])
    meet = Meet.find(params[:meet][:id])
    meet_leader = find_meet_leader(meet)
    redirect_to membership_path unless member == meet_leader
  end

  def meet_open?
    @meet = Meet.find(params[:meet_id])
    return true if @meet.opens_on.nil?

    unless @meet.opens_on <= Date.today
      flash[:danger] = 'Sorry, this meet is not yet open.'
      redirect_to meets_member_path(@member, { meet: { id: params[:meet_id] } })
    end
  end

  def run_ballot(pending_attendees)
    puts pending_attendees.length
    available_places = @meet.places - @meet.attendees.where(status: 'confirmed').count
    to_confirm = pending_attendees.sample(available_places)
    to_reserve = pending_attendees - to_confirm
    Attendee.where(id: to_confirm.map(&:id)).update_all(status: 'confirmed')
    Attendee.where(id: to_reserve.map(&:id)).update_all(status: 'reserve')
  end

  def meet_params
    params.require(:meet).permit(
      :id,
      :bb_url,
      :notes,
      :location
    )
  end

  def attendee_params
    params.require(:attendee).permit(
      :id,
      :update_paid,
      :update_meet_leader
    )
  end
end
