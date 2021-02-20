class Committee::MeetsController < Committee::BaseController
  helper_method :find_meet_leader

  include MeetsHelper

  def new
    @meet = Meet.new
  end

  def create
    @meet = Meet.new(meet_params)
    if @meet.save
      if attendee_params[:member_id] != nil
        attendee = Attendee.create(
                        meet_id: @meet.id,
                        member_id: attendee_params[:member_id],
                        is_meet_leader: true,
                        paid: false,
                        sign_up_date: Date.today)
        attendee.save
      end
      flash[:success] = 'Meet created'
      redirect_to committee_meets_path
    else
      render 'new'
    end
  end

  def index
    @future_meets = all_future_meets
  end

  def past
    @past_meets = Meet.where('meet_date < ?', Date.today).all.order(meet_date: :desc)
  end

  def edit
    @meet = Meet.find(params[:id])
    @meet_leader = find_meet_leader(@meet)
    @meet_leader_attendee = @meet_leader.attendees.where(meet_id: @meet.id).first if @meet_leader
    @meet_attendees = @meet.attendees.where(is_meet_leader: false).order(sign_up_date: :asc)
    attendee_member_ids = @meet_attendees.map { | attendee | attendee.member.id }
    attendee_member_ids.push(@meet_leader.id) if @meet_leader
    @remaining_members = Member.where.not(id: attendee_member_ids).order(first_name: :ASC)
    @new_attendee = Attendee.new
  end

  def update
    # fix this - see meets_controller.rb
    @meet = Meet.find(params[:id])
    if @meet.update_attributes(meet_params)
      if attendee_params[:member_id] != nil && @meet_leader == nil && !member_is_on_meet?(attendee_params[:member_id], @meet.id)
        attendee = Attendee.create(
          meet_id: @meet.id,
          member_id: attendee_params[:member_id],
          is_meet_leader: true,
          paid: false,
          sign_up_date: Date.today)
        attendee.save
      elsif member_is_on_meet?(attendee_params[:member_id], @meet.id)
        flash[:warning] = 'Selected meet leader already on meet'
      end
      flash[:success] = 'Meet updated'
      redirect_to edit_committee_meet_path(@meet)
    else
      render 'edit'
    end
  end

  def destroy
    meet = Meet.find(params[:id])
    Attendee.where(meet_id: meet.id).destroy_all
    meet.destroy
    flash[:success] = 'Meet deleted.'
    redirect_to committee_meets_path
  end

  private

  def meet_params
    params.require(:meet).permit(:meet_date,
                                 :location,
                                 :bb_url,
                                 :meet_type,
                                 :number_of_nights,
                                 :places,
                                 :activity,
                                 :notes,
                                 :opens_on,
                                 attendees_attributes: [
                                   :member_id
                                  ]
                                 )
  end

  def attendee_params
    params.require(:attendees).permit(:member_id)
  end
end
