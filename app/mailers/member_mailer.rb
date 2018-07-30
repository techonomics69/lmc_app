class MemberMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_mailer.password_reset.subject
  #
  def password_reset(member)
    @member = member
    mail to: member.email, subject: "Password reset"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_mailer.welcome_message.subject
  #
  def welcome_message(member, content)
    @member = member
    @email = content
    mail to: member.email, subject: "#{content.subject}"
  end

  def application_notification(member)
    @member = member
    mail from: "donotreply@leedsmc.org", to: "leedsmc@gmail.com", subject: "New LMC Member! Woop Woop!"
  end

  def newsfeed(email_add, m_name, content)
    @m_name = m_name
    @m_add = email_add
    @email = content
    mail to: email_add, subject: "#{content.subject}"
  end

  def subs_reminder(member, content)
    @recipient = member
    @email = content
    mail to: member.email, subject: "#{content.subject}"
  end
end
