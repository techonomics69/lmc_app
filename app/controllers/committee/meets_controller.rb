class Committee::MeetsController < Committee::BaseController

  def new
  	@meet = Meet.new
  end

  def create
  	@meet = Meet.new(meet_params)
  	if @meet.save
  		flash[:success] = "Meet created"
  		redirect_to committee_meets_path
  	else
  		render 'new'
  	end
  end

  def index
  	@future_meets = future_meets
  end

  def past
  	@past_meets = Meet.where('meet_date < ?', Date.today).all.order(meet_date: :desc)
  end

  def edit
  	@meet = Meet.find(params[:id])
  end

  def update
    @meet = Meet.find(params[:id])
    if @meet.update_attributes(meet_params)
      flash[:success] = "Meet updated"
      redirect_to committee_meets_path
    else
      render 'edit'
    end
  end

  def destroy
  	Meet.find(params[:id]).destroy
  	flash[:success] = "Meet deleted."
  	redirect_to committee_meets_path
  end

  private

  def meet_params
  	params.require(:meet).permit(:meet_date, 
  																	:member_id, 
  																	:location, 
  																	:bb_url, 
  																	:meet_type, 
  																	:number_of_nights, 
  																	:places,
                                    :activity,
  																	:notes)
  end

  
end
