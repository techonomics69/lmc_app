class MembersController < ApplicationController

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
  		redirect_to @member #update this to redirect to emergency contact form
  	else
  		render 'new'
  	end
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
end
