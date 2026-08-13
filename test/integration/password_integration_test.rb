# test/integration/password_integration_test.rb
require "test_helper"

class PasswordIntegrationTest < ActionDispatch::IntegrationTest
  test "requests a password reset for a known email" do
    assert_enqueued_email_with PasswordsMailer, :reset, args: [users(:alice)] do
      post passwords_url, params: { email_address: users(:alice).email_address }
    end
    assert_redirected_to new_session_url
  end

  test "does not send a password reset email for an unknown email" do
    assert_no_enqueued_emails do
      post passwords_url, params: { email_address: "missing@example.com" }
    end
    assert_redirected_to new_session_url
  end

  test "updates the password with a valid token" do
    user = users(:alice)
    token = user.password_reset_token

    assert_changes -> { user.reload.password_digest } do
      put password_url(token), params: {
        password: "new-password",
        password_confirmation: "new-password"
      }
    end
    assert_redirected_to new_session_url
  end

  test "rejects a mismatched password confirmation" do
    user = users(:alice)
    token = user.password_reset_token

    assert_no_changes -> { user.reload.password_digest } do
      put password_url(token), params: {
        password: "new-password",
        password_confirmation: "different"
      }
    end
    assert_redirected_to edit_password_url(token)
  end
end

