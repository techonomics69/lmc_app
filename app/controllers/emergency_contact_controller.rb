class EmergencyContactController < ApplicationController
	before_action :logged_in_member, only: [:edit, :update]
  before_action :correct_member, only: [:edit, :update]

	def edit
		@member = Member.find(params[:id])
	end

	def update
		@member = Member.find(params[:id])
	  if @member.update_attributes(emergency_contact_params)
	  	flash[:success] = "Emergency contact updated"
	     redirect_to @member
	  else
	  	render 'edit'
	  end
	end

  private

	  def emergency_contact_params
	  	params.require(:member).permit(emergency_contact_attributes: [ 
	  															 :id,
	  															 :name,
	  															 :address_1,
	  															 :address_2,
	  															 :address_3,
	  															 :town,
	  															 :postcode,
	  															 :country,
	  															 :primary_phone,
	  															 :secondary_phone,
	  															 :relationship])
	  end
end