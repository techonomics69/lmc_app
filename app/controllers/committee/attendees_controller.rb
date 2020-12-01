class Committee::AttendeesController < Committee::BaseController
  skip_before_action :committee_member
  before_action :committee_member_or_meet_leader

  include MeetsHelper

  def create
    @meet = Meet.find(params[:attendee][:meet_id])
    @attendee = @meet.attendees.create(attendee_params)
    if @attendee.save
      flash[:success] = 'Attendee added'
      redirect_to edit_committee_meet_path(@meet)
    else
      flash[:danger] = @attendee.errors.full_messages.to_sentence
      redirect_to edit_committee_meet_path(@meet)
    end
  end

  def update
    # @member = Member.find(params[:member_id])
    meet = Meet.find(params[:id])
    print(meet)
    attendee = Attendee.find_by(id: params[:attendee_id])
    print(attendee)
    if params[:update_paid]
      attendee.toggle!(:paid)
      redirect_to edit_committee_meet_path(meet)
    end
    print(params[:update_meet_leader])
    if params[:update_meet_leader] 
      if params[:meet_leader_attendee]
        old_meet_leader = Attendee.find_by(id: params[:meet_leader_attendee])
        old_meet_leader.update_attributes!(is_meet_leader: false)
      end
      attendee.update_attributes!(is_meet_leader: true)
      redirect_to edit_committee_meet_path(meet)
    end
  end

  def destroy
    attendee = Attendee.find(params[:attendee_id])
    attendee.destroy
    redirect_to edit_committee_meet_path
  end

  private

  def attendee_params
    params.require(:attendee).permit(
      :member_id,
      :is_meet_leader,
      :sign_up_date,
      :paid,
    )
  end

  #before_filters

  def committee_member_or_meet_leader
    if logged_in?
      @member = Member.find(session[:member_id])
      unless committee_member?(@member) || meet_leader?(@member, @meet) 
        flash[:danger] = "Restriced Access."
        redirect_to membership_path
      end
    else
      redirect_to root_url
    end
  end
end