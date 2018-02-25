require 'test_helper'

class MemberMailerTest < ActionMailer::TestCase
  test "password_reset" do
    member = members(:luke)
    member.reset_token = Member.new_token
    mail = MemberMailer.password_reset(member)
    assert_equal "Password reset", mail.subject
    assert_equal [member.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match member.reset_token,        mail.body.encoded
    assert_match CGI.escape(member.email),  mail.body.encoded
  end

#  test "welcome_message" do
#    mail = MemberMailer.welcome_message
#    assert_equal "Welcome message", mail.subject
#    assert_equal ["to@example.org"], mail.to
#    assert_equal ["from@example.com"], mail.from
#    assert_match "Hi", mail.body.encoded
#  end

end
