# test/mailers/recipe_mailer_test.rb
require "test_helper"

class RecipeMailerTest < ActionMailer::TestCase
  include Rails.application.routes.url_helpers

  test "shares a recipe" do
    recipe = recipes(:pancakes)
    sender = users(:alice).email_address
    email = RecipeMailer.share(recipe, "friend@example.com", sender)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["friend@example.com"], email.to
    assert_equal ["from@example.com"], email.from
    assert_includes email.subject, sender
    assert_includes email.body.encoded, sender
    assert_includes email.body.encoded, recipe.title
    assert_match recipe_path(recipe), email.body.encoded
  end

  test "guest shares a recipe" do
    recipe = recipes(:pancakes)
    email = RecipeMailer.share(recipe, "friend@example.com")

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["friend@example.com"], email.to
    assert_equal ["from@example.com"], email.from
    assert_includes email.subject, "Someone has shared"
    assert_includes email.body.encoded, "Someone has shared"
    assert_includes email.body.encoded, recipe.title
    assert_match recipe_path(recipe), email.body.encoded
  end
end
