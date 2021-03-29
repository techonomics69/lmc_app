class Committee::AttendeesController < Committee::BaseController
  skip_before_action :committee_member
  before_action :committee_member_or_meet_leader

  include MeetsHelper

  def create
    @meet = Meet.find(attendee_params[:meet_id])
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
    meet = Meet.find(params[:id])
    attendee = Attendee.find(attendee_params[:attendee_id])
    if params[:update_paid]
      attendee.toggle!(:paid)
      return redirect_to edit_committee_meet_path(meet)
    end
    if params[:update_meet_leader] 
      unless attendee_params[:meet_leader_attendee] == ""
        old_meet_leader = Attendee.find(attendee_params[:meet_leader_attendee])
        old_meet_leader.update_attributes!(is_meet_leader: false)
      end
      attendee.update_attributes!(is_meet_leader: true)
      redirect_to edit_committee_meet_path(meet)
    end
  end

  def destroy
    attendee = Attendee.find(attendee_params[:attendee_id])
    attendee.destroy
    redirect_to edit_committee_meet_path
  end

  private

  def attendee_params
    params.require(:attendee).permit(
      :attendee_id,
      :member_id,
      :meet_id,
      :is_meet_leader,
      :sign_up_date,
      :paid,
      :meet_leader_attendee
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