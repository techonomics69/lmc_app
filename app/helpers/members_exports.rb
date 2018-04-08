module MembersExports

	def all
		members = Member.order(:last_name)
		respond_to do |format|
			format.html
			format.csv { send_data members.to_csv_with_membership_and_emergency_contact }
		end
	end

	def for_bmc
		year = Date.today.year - 1
#		members = Member.joins(:membership).where(memberships: {fees_received_on: Date.new(year,10,1)..Date.today}).or(memberships: {membership_type: "Honorary"}
		members = Member.joins(:membership).where("memberships.membership_type = ? OR memberships.fees_received_on between ? and ?", "Honorary", Date.new(year,10,1) ,Date.today)
#		members = Member.joins(:membership).where(memberships: {fees_received_on: Date.new(year,10,1)..Date.today})
#		honorary = Member.joins(:membership).where(memberships: {membership_type: "Honorary"})
#		all_members = members.or(honorary).order(:last_name)
		respond_to do |format|
			format.html
			format.csv { send_data members.to_csv_for_bmc }
		end
	end

	def export
		members = Member.where(id: params[:selected])
		case route_to params
	  	when :export_all
#	  		all_selected
				data = members.to_csv_with_membership_and_emergency_contact
	  	when :members
#	  		selected_members
				data = members.to_csv_members
	  	when :membership
#	  		selected_membership
				data = members.to_csv_membership
	  	when :em_cont
#	  		selected_em_cont
				data = members.to_csv_emergency_contact
			when :bmc
				year = Date.today.year - 1
				bmc_members = members.joins(:membership).where(memberships: {fees_received_on: Date.new(year,10,1)..Date.today}).order(:last_name)
				data = bmc_members.to_csv_for_bmc
	  end
		csv_file_path = create_csv_file(data)
		flash.now[:success] = "Data exported. Click <a href='/committee/members/download_file.csv'>here</a> to download CSV file.".html_safe
		@members = Member.joins(:membership).order("#{sort_column} #{sort_direction}")
		render 'index'
	end

	def download_file
		path = session[:file]
		if File.exist?(path)
			file = File.open(path)
			contents = file.read
			file.close
			send_data contents, :type => 'text/csv', :filename => 'members_download.csv'
		else
			flash.now[:danger] = "No file yet! Just give it a few more seconds and click <a href='/committee/members/download_file.csv'>here</a> to try again. If it still doesn't work try exporting again.".html_safe
			@members = Member.joins(:membership).order("#{sort_column} #{sort_direction}")
			prepend_view_path('app/views/committee/members')
			render 'index.html.erb'
		end
	end

	private

	def create_csv_file(data)
		tmp = Tempfile.new(['db-download', '.csv'])
		tmp.write(data)
		tmp.close
		session[:file] = tmp.path
	end


end