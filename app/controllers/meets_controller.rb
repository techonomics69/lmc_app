class MeetsController < ApplicationController
  before_action :logged_in_member
  before_action :correct_member
  before_action :meet_leader

  include MeetsHelper

  def edit
    puts "##################################"
    @meet = Meet.find(params[:meet][:id]) #is this correct for params?
    @new_attendee = Attendee.new
    @meet_leader = find_meet_leader(@meet)
    @meet_leader_attendee = @meet_leader.attendees.first if @meet_leader
    @meet_attendees = @meet.attendees.where(is_meet_leader: false).order(sign_up_date: :asc)
    @remaining_members = Member.where.not(id: @meet_attendees.map { |attendee| attendee.member.id }).order(first_name: :ASC)
  end

  def create_attendee
    attendee = Attendee.create(
      meet_id: meet_params[:id],
      member_id: attendee_params[:member_id],
      is_meet_leader: false,
      paid: attendee_params[:paid],
      sign_up_date: attendee_params[:sign_up_date]
    )
    if attendee.save
      flash[:success] = 'Attendee added.'
      redirect_to meets_member_path(@member, {:meet => {:id => meet_params[:id]}})
    else
      flash[:error] = 'Error adding attendee.'
      redirect_to meets_member_path(@member, {:meet => {:id => meet_params[:id]}})
    end
  end

  def update
    puts "##################################"
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
      # current_leader = Attendee.find(params[:attendee][:id]) ...check this...
      current_leader = find_meet_leader(meet).attendees.first
      if attendee.toggle!(:is_meet_leader) && current_leader.update_attribute(:is_meet_leader, false)
        redirect_to meets_member_path(@member, {:meet => {:id => meet.id}})
      else
        flash[:error] = 'Failed to update meet leader.'
      end
    end


    # if @meet.update_attributes(meet_params)
    #   if attendee_params[:id] != nil && @meet_leader == nil && !member_is_on_meet?(attendee_params[:member_id], @meet.id)
    #     attendee = Attendee.create(
    #       meet_id: @meet.id,
    #       member_id: attendee_params[:member_id],
    #       is_meet_leader: true,
    #       paid: false,
    #       sign_up_date: Date.today)
    #     attendee.save
    #   elsif member_is_on_meet?(attendee_params[:member_id], @meet.id)
    #     flash[:warning] = 'Selected meet leader already on meet'
    #   end
    #   flash[:success] = 'Meet updated'
    #   redirect_to meets_member_path(@member)
    # else
    #   render 'edit'
    # end
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
                                  :location)
  end

  def attendee_params
    params.require(:attendee).permit(:id,
                                      :member_id,
                                      :paid,
                                      :sign_up_date)
  end

end