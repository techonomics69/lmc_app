class MembersController < ApplicationController
  before_action :logged_in_member, only: [:show, :edit, :update]
  before_action :correct_member, only: [:show, :edit, :update]

  include MembersHelper

	def show
		@member = Member.find(params[:id])
	end

  def new
  	@member = Member.new
  end

  def create
  	@member = Member.new(member_params)
  	if @member.save
  		log_in @member
  		flash[:success] = "Welcome to the Leeds Mountaineering Club!"
  		redirect_to member_path(@member)
  	else
  		render 'new'
  	end
  end

  def update
#  	@member = Member.find(params[:id])
  	if @member.update_attributes(member_params)
  		flash[:success] = "Details updated"
      redirect_to @member
  	else
  		render 'edit'
  	end
  end

  def edit
  end

  def index
    redirect_to current_user
  end

  private

	  def member_params
	  	params.require(:member).permit(:first_name,
	  															 :last_name,
	  															 :address_1,
	  															 :address_2,
	  															 :address_3,
	  															 :town,
	  															 :postcode,
	  															 :country,
	  															 :phone,
	  															 :email,
	  															 :dob,
	  															 :experience,
	  															 :accept_risks,
	  															 :password, 
	  															 :password_confirmation)
	  end

    #Before filters

    #confirms member is logged in

end
