class Committee::EmailsController < Committee::BaseController
  include EmailsHelper

  def new
    @template = template
    @email = Email.new
  end

  def create
    @email = Email.new(email_params)
    if @email.save
      flash[:success] = "Email Saved"
      redirect_to edit_committee_email_path(@email)
    else
      flash[:danger] = "Error, email not saved."
      render 'new'
    end
  end

  def index
    @emails = Email.where("default_template = ?", false).order(sent_on: :DESC, updated_at: :DESC)
    @welcome_email = Email.find_by_default_template_and_template(true, "welcome")
  end

  def edit
    @email = Email.find(params[:id])
    @template = @email
  end

  def show
    @email = Email.find(params[:id])
  end

  def update
    @email = Email.find(params[:id])
    @template = @email
    unless @email.default_template == true && @email.template != "welcome"
      if @email.update_attributes(email_params)
        flash.now[:success] = "Email updated"
        render 'edit'
      else
        flash.now[:danger] = "Something went wrong. Email not updated."
        render 'edit'
      end
    else
      flash.now[:danger] = "Cannot overwrite default template."
      render 'edit'
    end
  end

  def email_preview
    @email = Email.find(params[:id])
    @recipient = @email.member
    render :file => 'member_mailer/newsfeed.html.erb', :layout => 'mailer'
  end

  def send_email
    sent_to = 0
    @email = Email.find(params[:id])
    recipients
    @recipients.each do |rec|
      MemberMailer.newsfeed(rec, @email).deliver_now
      sent_to += 1
    end
    @email.update_columns(sent_to: sent_to, sent_on: DateTime.now)
    flash[:success] = "Sending Emails..."
    redirect_to committee_emails_path
  end

  def destroy
  end

  private

  def email_params
    params.require(:email).permit(:member_id,
                                  :template,
                                  :style,
                                  :subject,
                                  :body)
  end
end
