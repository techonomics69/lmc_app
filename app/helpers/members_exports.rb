module MembersExports

  def export_checked
  	if params[:selected].nil?
	  	flash[:danger] = "No members selected."
	  	@members = Member.joins(:membership).order("#{sort_column} #{sort_direction}")
	  	return redirect_to committee_members_path
	  else
			checked = Member.find(params[:selected])
			csv_file_path = create_csv_file(checked)
			flash.now[:success] = "Click <a href='/committee/members/download_file.csv'>here</a> to download.".html_safe
			@members = Member.joins(:membership).order("#{sort_column} #{sort_direction}")
			render 'index'
		end
	end

	def download_file
		path = session[:file]
		file = File.open(path)
		contents = file.read
		file.close
		send_data contents, :type => 'text/csv', :filename => 'members_download.csv'
	end

	private

	def create_csv_file(data)
		tmp = Tempfile.new(['db-download', '.csv'])
		tmp.write(data)
		tmp.close
		session[:file] = tmp.path
	end

	def all
		@members = Member.joins(:membership).order(:last_name)
		respond_to do |format|
			format.html
			format.csv { send_data @members.to_csv }
		end
	end
end