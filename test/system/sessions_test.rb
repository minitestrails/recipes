# test/system/sessions_test.rb
require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  test "signs in" do
    visit new_session_url
    fill_in "Enter your email address", with: users(:alice).email_address
    fill_in "Enter your password", with: "password"
    click_on "Sign in"

    assert_selector "h1", text: "Recipes"
    assert_text "Sign out"
  end

  test "signs out" do
    sign_in_to_ui_as users(:alice)
    visit recipes_url
    click_on "Sign out"
    assert_current_path new_session_path
    assert_button "Sign in"
  end
end
