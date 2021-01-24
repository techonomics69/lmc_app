class AttendeesController < ApplicationController
  before_action :logged_in_member
  before_action :correct_member

  def index
    @meets = all_future_meets
  end

  def new
    @member = Member.find(params[:id])
    @meet = Meet.find(params[:meet_id])
    print(params)
  end
end