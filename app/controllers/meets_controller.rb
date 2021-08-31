class MeetsController < ApplicationController
  before_action :logged_in_member
  before_action :correct_member
  before_action :meet_leader

  include MeetsHelper

  def edit
    @meet = Meet.find(params[:meet][:id])
    @new_attendee = Attendee.new
    @meet_leader = find_meet_leader(@meet)
    @meet_leader_attendee = @meet_leader.attendees.first if @meet_leader
    @meet_attendees = @meet.attendees.where(is_meet_leader: false).order(sign_up_date: :asc)
    @remaining_members = Member.where.not(id: @meet_attendees.map { |attendee| attendee.member.id }).order(first_name: :ASC)
  end

  def update
    @meet = Meet.find(meet_params[:id])

    if @meet.update_attributes(meet_params)
        flash[:success] = "Meet updated"
    else
        render 'edit' and return
    end

    redirect_to meets_member_path(@member, {:meet => {:id => @meet.id}})
  end

  private

  def meet_leader
  	member = Member.find(params[:id])
  	meet = Meet.find(params[:meet][:id])
    meet_leader = find_meet_leader(meet)
  	redirect_to membership_path unless member == meet_leader
  end

  def meet_params
  	params.require(:meet).permit(
      :id,
      :bb_url, 
      :notes,
      :location,
      :opens_on
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