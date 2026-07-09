# test/models/ingredient_test.rb
require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  test "is valid" do
    assert ingredients(:salt).valid?
  end

  test "rejects blank name" do
    ingredient = Ingredient.new(name: "", quantity: 1, unit: "cup")
    assert_not ingredient.valid?
    assert_includes ingredient.errors[:name], "can't be blank"
  end

  test "rejects negative quantity" do
    ingredient = Ingredient.new(name: "Pepper", quantity: -1, unit: "g")
    assert_not ingredient.valid?
    assert_includes ingredient.errors[:quantity], "must be greater than 0"
  end
end
