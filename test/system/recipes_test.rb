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

    click_on "Add ingredient"
    all("input[name*='[ingredients_attributes]'][name*='[name]']").last.set(
      "Onion"
    )

    click_on "Add step"
    all("textarea[name*='[steps_attributes]'][name*='[instruction]']").last.set(
      "Flip when bubbles form"
    )

    click_on "Add ingredient"
    all("button", text: "Remove ingredient").last.click

    within find(
             "input[name*='[ingredients_attributes]'][name*='[name]'][value='Salt']"
           ).ancestor("[data-nested-form-target='row']") do
      click_on "Remove ingredient"
    end

    click_on "Update Recipe"

    assert_text "Extra fluffy pancakes"
    assert_no_text "Salt"
    assert_text "Flour"
    assert_text "Onion"
    assert_text "Flip when bubbles form"
  end

  test "destroys a recipe" do
    recipe = recipes(:lentil_soup)
    visit recipe_url(recipe)

    accept_confirm do
      click_on "Destroy this recipe"
    end

    assert_current_path recipes_path
    assert_no_text recipe.title
  end

  test "destroys a recipe from the list" do
    recipe = recipes(:lentil_soup)
    visit recipes_url

    assert_text recipe.title
    assert_text recipes(:pancakes).title

    accept_confirm do
      within("##{dom_id(recipe)}") { click_on "Destroy this recipe" }
    end

    assert_current_path recipes_path
    assert_no_text recipe.title
    assert_text recipes(:pancakes).title
  end

  test "removes ingredients and steps from the detail page" do
    recipe = recipes(:pancakes)
    visit recipe_url(recipe)

    assert_text "Salt"
    assert_text "Flour"
    assert_text steps(:preheat).instruction

    accept_confirm do
      within("##{dom_id(ingredients(:salt))}") { click_on "Remove" }
    end

    accept_confirm do
      within("##{dom_id(steps(:preheat))}") { click_on "Remove" }
    end

    assert_no_text "Salt"
    assert_text "Flour"
    assert_no_text steps(:preheat).instruction
  end

  test "filters the list" do
    visit recipes_url
    assert_text recipes(:pancakes).title
    assert_text recipes(:lentil_soup).title

    select "Quick recipes (under 30 min)", from: "Show"
    click_on "Apply filter"

    assert_text recipes(:pancakes).title
    assert_no_text recipes(:lentil_soup).title
  end
end
