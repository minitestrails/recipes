# test/system/recipes_test.rb
require "application_system_test_case"

class RecipesTest < ApplicationSystemTestCase
  test "visits the list" do
    visit recipes_url
    assert_selector "h1", text: "Recipes"
    assert_text recipes(:pancakes).title
  end

  test "shows a recipe" do
    recipe = recipes(:lentil_soup)
    visit recipe_url(recipe)
    assert_text recipe.title
  end

  test "creates a recipe" do
    visit new_recipe_url
    fill_in "Title", with: "Tomato soup"
    fill_in "Name", with: "Tomatoes"
    fill_in "Quantity", with: "400"
    fill_in "Unit", with: "g"
    fill_in "Position", with: "1"
    fill_in "Instruction", with: "Simmer until the tomatoes soften"
    click_on "Create Recipe"
    assert_text "Tomato soup"
    assert_text "Tomatoes (400 g)"
    assert_text "Simmer until the tomatoes soften"
  end

  test "updates a recipe" do
    recipe = recipes(:pancakes)
    visit edit_recipe_url(recipe)
    fill_in "Title", with: "Extra fluffy pancakes"
    click_on "Update Recipe"
    assert_text "Extra fluffy pancakes"
  end

  test "destroys a recipe" do
    recipe = recipes(:lentil_soup)
    visit recipe_url(recipe)
    accept_confirm { click_on "Destroy this recipe" }
    assert_no_text recipe.title
  end
end
