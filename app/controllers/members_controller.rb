class MembersController < ApplicationController
  before_action :logged_in_member, only: [:edit, :update]
  before_action :correct_member, only: [:edit, :update]

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

  def update
#  	@member = Member.find(params[:id])
  	if @member.update_attributes(member_params)
  		flash[:success] = "Profile updated"
      redirect_to @member
  	else
  		render 'edit'
  	end
  end

  def edit
#  	@member = Member.find(params[:id])
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
    def logged_in_member
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_member
      @member = Member.find(params[:id])
      redirect_to(root_url) unless current_user?(@member)
    end
end
