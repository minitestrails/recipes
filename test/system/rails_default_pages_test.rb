require "application_system_test_case"

class RailsDefaultPagesTest < ApplicationSystemTestCase
  test "health check responds over the browser" do
    visit "/up"
    assert_current_path "/up"
  end
end
