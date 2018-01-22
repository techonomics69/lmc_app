module MembersMultiple
	def edit_multiple
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
end