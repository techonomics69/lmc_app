class Committee::MembersController < Committee::BaseController
	helper_method :sort_column, :sort_direction

	def index
		@members = Member.joins(:membership).order("#{sort_column} #{sort_direction}")
		recall_selected(@members)
	end

	def show
		remember_selected
		@member = Member.find(params[:id])
	end

	def edit
		remember_selected
		@member_to_edit = Member.find(params[:id])
	end

	def update
  	@member_to_edit = Member.find(params[:id])
  	if @member_to_edit.update_attributes(member_params)
  		flash[:success] = "Member updated"
      redirect_to committee_members_path
  	else
  		render 'edit'
  	end
  end

  def edit_multiple
  	remember_selected
  	if params[:selected].nil? == true
	  	flash.now[:danger] = "No members selected."
	  	@members = Member.joins(:membership).order("#{sort_column} #{sort_direction}")
	  	return render 'index'
	  end
  	@members_to_edit = Member.find(params[:selected])
  	@no_of_members_to_edit = @members_to_edit.count
  end

  def update_multiple
  	@members_to_edit = Member.joins(:membership).find(params[:member_ids])

 		@members_edited = 0
 		@failed = 0
  	@members_to_edit.reject! do |m|
  		if m.membership.update_attributes(membership_params.reject {|k,v| v.blank? })
  			@members_edited += 1
  		else
  			@failed += 1
  		end
	  end

	  if @failed == 0
		  clear_selected(@members_to_edit)
		  flash[:success] = "#{@members_edited} members updated."
		  redirect_to committee_members_path
  	elsif @members_to_edit.empty?
  		flash[:danger] = "No members selected."
  		redirect_to committee_members_path
  	else
  		@members_to_edit = Member.find(params[:member_ids])
  		params[:selected] = @members_to_edit
  		@no_of_members_to_edit = @members_to_edit.count #used for pluralization in view
  		flash.now[:danger] = "Failed to update #{@failed} records. Please try again or contact the site admin."
  		render 'edit_multiple'
  	end

  end

  def destroy
  	Member.find(params[:id]).destroy
  	flash[:success] = "Member removed from database."
  	redirect_to committee_members_path
  end

end

private

def member_params
	params.require(:member).permit(#:first_name,
	  														 #:last_name,
	  														 :address_1,
	  														 :address_2,
	  														 :address_3,
	  														 :town,
	  														 :postcode,
	  														 :country,
	  														 :phone,
	  														 :email,
	  														 :dob,
	  														# :experience,
	  														# :accept_risks,
	  														# :password, 
	  														# :password_confirmation
	  														membership_attributes: [:bmc_number, :membership_type, :welcome_pack_sent,:fees_received_on, :notes, :id])
	end

	def membership_params
		params.require(:membership).permit(:bmc_number, :membership_type, :welcome_pack_sent,:fees_received_on, :notes)
	end

def sort_column
	if 
		Member.column_names.include?(params[:sort])
		return params[:sort]
	elsif 
		Membership.column_names.include?(params[:sort])
		return params[:sort]
	else
		"first_name"
	end
end

def sort_direction
	%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
end