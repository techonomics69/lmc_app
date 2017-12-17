class MeetsController < ApplicationController
  before_action :logged_in_member
  before_action :correct_member
  before_action :meet_leader

  def edit
  	@meet = Meet.find(params[:meet][:id])
  end

  def update
  	@meet = Meet.find(params[:meet][:id])
  	if @meet.update_attributes(meet_params)
  		flash[:success] = "Meet updated"
      redirect_to @member
  	else
  		render 'edit'
  	end
  end

  private

  def meet_leader
  	member = Member.find(params[:id])
  	meet = Meet.find(params[:meet][:id])
  	meet_leader = meet.member_id.to_i
  	redirect_to membership_path unless member.id == meet_leader
  end

  def meet_params
  	params.require(:meet).permit(:bb_url, 
  																:notes)
  end

end