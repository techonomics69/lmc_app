class Committee::MembersController < Committee::BaseController
	helper_method :sort_column, :sort_direction
	
	include MembersExports
	include MembersMultiple

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

  def multiple
  	remember_selected
  	if params[:selected].nil?
	  	flash[:danger] = "No members selected."
	  	@members = Member.joins(:membership).order("#{sort_column} #{sort_direction}")
	  	redirect_to committee_members_path
	  	return
	  else
	  	case route_to params
	  	when :edit
	  		edit_multiple
	  	else
	  		export
	  	end
	  end
  end

  def edit_role
		@members = Member.joins(:membership).order("#{sort_column} #{sort_direction}")
		@committee_positions_list = committee_positions_list
  end

  def update_role
  	@member_to_assign_role = Member.find(params[:id])
  	@member_to_remove_role = Member.joins(:membership).find_by(memberships: {committee_position: params[:membership][:committee_position]})
  	if params[:membership][:committee_position] == "- remove role -"
  		if @member_to_assign_role.membership.update_attributes!(committee_position: nil)
  			flash[:success] = "#{@member_to_assign_role.first_name} #{@member_to_assign_role.last_name} is no longer on the committee"
  		end
  	else
  		@member_to_remove_role.membership.update_attributes!(committee_position: nil) unless @member_to_remove_role.nil?
  	end
  	
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
	  														 :bb_name,
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

	def sort_column(default="last_name")
		if 
			Member.column_names.include?(params[:sort])
			return params[:sort]
		elsif 
			Membership.column_names.include?(params[:sort])
			return params[:sort]
		else
			default
		end
	end

	def sort_direction(default = "asc")
		%w[asc desc].include?(params[:direction]) ? params[:direction] : default
	end

	def route_to params
		params[:route_to].keys.first.to_sym unless params[:route_to].nil?
	end

	def committee_positions_list
		["Chair",
		"Treasurer",
		"Meets Secretary",
		"Membership Secretary",
		"Communications Secretary",
		"Social Secretary",
		"Climbing Co-ordinator",
		"Walking Co-ordinator",
		"Ordinary Member",
		"Extra Ordinary Member",
		"Member Without Portfolio",
		"",
		"site admin",
		"- remove role -"]
	end