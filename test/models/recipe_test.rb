require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  test "rejects a blank title" do
    recipe = Recipe.new(title: "")
    assert_not recipe.valid?
    assert_includes recipe.errors[:title], "can't be blank"
  end
end
