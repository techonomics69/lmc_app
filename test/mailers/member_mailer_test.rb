require 'test_helper'

class MemberMailerTest < ActionMailer::TestCase
  test "password_reset" do
    member = members(:luke)
    member.reset_token = Member.new_token
    mail = MemberMailer.password_reset(member)
    assert_equal "Password reset", mail.subject
    assert_equal [member.email], mail.to
    assert_equal ["leedsmc@gmail.com"], mail.from
    assert_match member.reset_token,        mail.body.encoded
    assert_match CGI.escape(member.email),  mail.body.encoded
  end

  test "welcome_message" do
    member = members(:luke)
    mail = MemberMailer.welcome_message(member)
    assert_equal "Your Leeds Mountaineering Club Application", mail.subject
    assert_equal [member.email], mail.to
    assert_equal ["leedsmc@gmail.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
