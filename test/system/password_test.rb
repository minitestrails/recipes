# test/system/password_test.rb
require "application_system_test_case"

class PasswordTest < ApplicationSystemTestCase
  test "resets password" do
    user = users(:alice)

    visit new_session_url
    click_on "Forgot password?"
    fill_in "Enter your email address", with: user.email_address
    click_on "Email reset instructions"
    assert_text /reset instructions sent/i

    visit edit_password_url(user.password_reset_token)
    fill_in "Enter new password", with: "new-password"
    fill_in "Repeat new password", with: "new-password"
    click_on "Save"
    assert_text /Password has been reset/i

    fill_in "Enter your email address", with: user.email_address
    fill_in "Enter your password", with: "new-password"
    click_on "Sign in"
    assert_selector "h1", text: "Recipes"
    assert_text "Sign out"
  end
end
