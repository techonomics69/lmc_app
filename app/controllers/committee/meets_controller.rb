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
    create_values_for_edit()
  end

  def update
    @meet = Meet.find(params[:id])
    if @meet.update_attributes(meet_params)
      flash[:success] = 'Meet updated'
    end
      create_values_for_edit()
      render 'edit'
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
                                 :opens_on
                                 )
  end

  def attendee_params
    params.require(:attendees).permit(:member_id)
  end

  def create_values_for_edit
    @meet = Meet.find(params[:id])
    @meet_leader = find_meet_leader(@meet)
    @meet_leader_attendee = @meet_leader.attendees.where(meet_id: @meet.id).first if @meet_leader
    @meet_attendees = @meet.attendees.where(is_meet_leader: false).order(sign_up_date: :asc)
    attendee_member_ids = @meet_attendees.map { | attendee | attendee.member.id }
    attendee_member_ids.push(@meet_leader.id) if @meet_leader
    @remaining_members = Member.where.not(id: attendee_member_ids).order(first_name: :asc)
    @meet_has_reserves = @meet_leader ? @meet_attendees.length + 1 > @meet.places : @meet_attendees.length > @meet.places if !@meet.places.nil?
    @new_attendee = Attendee.new
  end
end
