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
    meet = Meet.find(params[:meet][:id])
    attendee = Attendee.find(params[:attendee][:id])
    if params[:update_paid]
      if attendee.toggle!(:paid)
        redirect_to meets_member_path(@member, {:meet => {:id => meet.id}})
      else
        flash[:error] = 'Failed to update payment status.'
        redirect_to meets_member_path(@member, {:meet => {:id => meet.id}})
      end
    end
    if params[:update_meet_leader]
      current_leader = find_meet_leader(meet).attendees.first
      if attendee.toggle!(:is_meet_leader) && current_leader.update_attribute(:is_meet_leader, false)
        redirect_to meets_member_path(@member, {:meet => {:id => meet.id}})
      else
        flash[:error] = 'Failed to update meet leader.'
      end
    end
  end

  private

  def meet_leader
  	member = Member.find(params[:id])
  	meet = Meet.find(params[:meet][:id])
    # meet_leader = meet.member_id.to_i
    meet_leader = find_meet_leader(meet)
  	redirect_to membership_path unless member == meet_leader
  end

  def meet_params
  	params.require(:meet).permit(:id,
                                 :bb_url, 
                                 :notes,
                                 :location,
                                 :opens_on)
  end

  def attendee_params
    params.require(:attendee).permit(:id,
                                     :member_id,
                                     :paid,
                                     :sign_up_date)
  end

end