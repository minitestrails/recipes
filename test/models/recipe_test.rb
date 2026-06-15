# test/models/recipe_test.rb
require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  test "is valid" do
    assert recipes(:pancakes).valid?
  end

  test "rejects a blank title" do
    recipe = Recipe.new(title: "")
    assert_not recipe.valid?
    assert_includes recipe.errors[:title], "can't be blank"
  end
end
