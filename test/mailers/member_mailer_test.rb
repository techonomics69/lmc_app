require 'test_helper'

class MemberMailerTest < ActionMailer::TestCase

  def setup
    @member = members(:luke)
    @content = emails(:welcome_message)
  end

  test "password_reset" do
    @member.reset_token = Member.new_token
    mail = MemberMailer.password_reset(@member)
    assert_equal "Password reset", mail.subject
    assert_equal [@member.email], mail.to
    assert_equal ["leedsmc@gmail.com"], mail.from
    assert_match @member.reset_token,        mail.body.encoded
    assert_match CGI.escape(@member.email),  mail.body.encoded
  end

  test "welcome_message" do
    mail = MemberMailer.welcome_message(@member, @content)
    assert_equal "#{@content.subject}", mail.subject
    assert_equal [@member.email], mail.to
    assert_equal ["leedsmc@gmail.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
