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
  	if params[:selected].nil?
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

  def edit_role
#		@committee_members = Member.joins(:membership).where.not(memberships: { committee_position: nil}).order('committee_position ASC')
#		@committee_members = Member.joins(:membership).find_by(memberships: { committee_position: nil})#.order('committee_position ASC')
		@members = Member.joins(:membership).order("#{sort_column} #{sort_direction}")
  end

  def update_role
  	@member_to_assign_role = Member.find(params[:id])
  	@member_to_remove_role = Member.joins(:membership).find_by(memberships: {committee_position: params[:membership][:committee_position]})
  	@member_to_remove_role.membership.update_attributes!(committee_position: nil) unless @member_to_remove_role.nil?
  	if @member_to_assign_role.membership.update_attributes(roles_params)
  		flash[:success] = "#{@member_to_assign_role.first_name} #{@member_to_assign_role.last_name} is now the #{@member_to_assign_role.membership.committee_position}"
  	else
  		flash.now[:danger] = "Failed to assign role. Pleae try again or contact the site admin."
  	end
		redirect_to saved_sort_or(committee_members_path)
		
  end

  def destroy
  	Member.find(params[:id]).destroy
  	flash[:success] = "Member removed from database."
  	redirect_to committee_members_path
  end

end

private

def member_params
	params.require(:member).permit(:address_1,
	  														 :address_2,
	  														 :address_3,
	  														 :town,
	  														 :postcode,
	  														 :country,
	  														 :phone,
	  														 :email,
	  														 :dob,
	  															membership_attributes: [
	  																:bmc_number, 
	  																:membership_type, 
	  																:welcome_pack_sent,
	  																:fees_received_on, 
	  																:notes, 
	  																:id ]
	  														)
	end

	def membership_params
		params.require(:membership).permit(:bmc_number, :membership_type, :welcome_pack_sent,:fees_received_on, :notes)
	end

	def roles_params
		params.require(:membership).permit(:committee_position)
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