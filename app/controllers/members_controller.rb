class MembersController < ApplicationController
  before_action :logged_in_member, only: [:show, :edit, :update]
  before_action :correct_member, only: [:show, :edit, :update]

  include MembersHelper
  helper_method :committee_member?

	def show
    @member = Member.find(params[:id])
    @future_meets = all_future_meets
	end

  def new
  	@member = Member.new
    @meta_description = "Application form to join the Leeds Mountaineering Club."
  end

  def create
  	@member = Member.new(member_params)
  	if @member.save
  		log_in @member
      @member.send_welcome_email
      send_application_notification
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
    @member = Member.find(params[:id])
  end

  def index
    if logged_in?
      redirect_to current_user
    else
      redirect_to login_url
    end
  end

  def destroy
    Member.find(params[:id]).destroy
    flash[:success] = "Your information has been removed."
    redirect_to root_url
  end

  def email_subscribe
    @member = Member.find(params[:id])
    redirect_to @member if @member.toggle!(:receive_emails)
  end

  private

	  def member_params
	  	params.require(:member).permit(:title,
                                   :first_name,
	  															 :last_name,
	  															 :address_1,
	  															 :address_2,
	  															 :address_3,
	  															 :town,
                                   :county,
	  															 :postcode,
	  															 :country,
	  															 :mob_phone,
                                   :home_phone,
	  															 :email,
	  															 :dob,
	  															 :experience,
                                   :bb_name,
	  															 :accept_risks,
                                   :receive_emails,
	  															 :password, 
	  															 :password_confirmation,
                                   membership_attributes: [
                                    :bmc_number,
                                    :id ])
	  end

  def send_application_notification
    MemberMailer.application_notification(@member).deliver_now
  end

end
