# Preview all emails at http://localhost:3000/rails/mailers/member_mailer
class MemberMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/member_mailer/password_reset
  def password_reset
  	member = Member.first
  	member.reset_token = Member.new_token
    MemberMailer.password_reset(member)
  end

  # Preview this email at http://localhost:3000/rails/mailers/member_mailer/welcome_message
  def welcome_message
    member = Member.first
    content = Email.first
    MemberMailer.welcome_message(member, content)
  end

  # Preview this email at http://localhost:3000/rails/mailers/member_mailer/newsfeed
  def newsfeed
    member = Member.first
    content = Email.first
    MemberMailer.newsfeed(member, content)
  end

end
