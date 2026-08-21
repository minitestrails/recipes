# test/models/recipe_test.rb
require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  test "is valid" do
    assert recipes(:pancakes).valid?
  end

  test "rejects a blank title" do
    recipe = Recipe.new(title: "", user: users(:alice))
    assert_not recipe.valid?
    assert_includes recipe.errors[:title], "can't be blank"
  end

  test "rejects negative prep time" do
    recipe = Recipe.new(title: "Soup", prep_time: -1, user: users(:alice))
    assert_not recipe.valid?
    assert_includes recipe.errors[:prep_time], "must be greater than 0"
  end

  test "rejects negative servings" do
    recipe = Recipe.new(title: "Soup", servings: -1, user: users(:alice))
    assert_not recipe.valid?
    assert_includes recipe.errors[:servings], "must be greater than 0"
  end

  test "rejects a whitespace-only description" do
    recipe = Recipe.new(title: "Soup", description: "   ", user: users(:alice))
    assert_not recipe.valid?
    assert_includes recipe.errors[:description], "can't be only spaces"
  end

  test "printable is true when title and servings are present" do
    assert recipes(:pancakes).printable?
  end

  test "printable is false without servings" do
    assert_not Recipe.new(title: "Soup", user: users(:alice)).printable?
  end

  test "strips whitespace from title before validation" do
    recipe = Recipe.new(title: "  Soup  ", prep_time: 15, servings: 4, user: users(:alice))
    assert recipe.valid?
    assert_equal "Soup", recipe.title
  end
end
