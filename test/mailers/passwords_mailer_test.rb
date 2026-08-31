# test/mailers/passwords_mailer_test.rb
require "test_helper"

class PasswordsMailerTest < ActionMailer::TestCase
  include Rails.application.routes.url_helpers

  test "reset a password by email" do
    freeze_time do
      user = users(:alice)
      email = PasswordsMailer.reset(user)

      assert_emails 1 do
        email.deliver_now
      end

      assert_equal [user.email_address], email.to
      assert_equal ["from@example.com"], email.from
      assert_equal "Reset your password", email.subject
      assert_match edit_password_path(user.password_reset_token), email.body.encoded
    end
  end
end
