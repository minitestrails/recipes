# test/integration/recipes_integration_test.rb
require "test_helper"

class RecipesIntegrationTest < ActionDispatch::IntegrationTest
  test "visits the list" do
    get recipes_url
    assert_response :success
    assert_match "Recipes", response.body
    assert_match recipes(:pancakes).title, response.body
    assert_select "#recipes div[id^='recipe_']", count: Recipe.count
  end

  test "shows a recipe" do
    get recipe_url(recipes(:pancakes))
    assert_response :success
    assert_match recipes(:pancakes).title, response.body
  end

  test "creates a recipe" do
    get new_recipe_url
    assert_response :success
    assert_match "New recipe", response.body

    assert_difference("Recipe.count", 1) do
      post recipes_url, params: { recipe: { title: "Lentil soup" } }
    end
    assert_redirected_to recipe_url(Recipe.last)
    follow_redirect!
    assert_response :success
    assert_match "Lentil soup", response.body
  end

  test "does not create a recipe with invalid data" do
    get new_recipe_url
    assert_response :success
    assert_select "h1", "New recipe"

    assert_no_difference("Recipe.count") do
      post recipes_url, params: { recipe: { title: "" } }
    end
    assert_response :unprocessable_entity
    assert_match /prohibited this recipe from being saved/i, response.body
    assert_select "h1", "New recipe"
  end

  test "updates a recipe" do
    recipe = recipes(:pancakes)

    get edit_recipe_url(recipe)
    assert_response :success
    assert_select "h1", "Editing recipe"

    patch recipe_url(recipe),
          params: {
            recipe: {
              title: "Extra fluffy pancakes"
            }
          }
    assert_redirected_to recipe_url(recipe)
    follow_redirect!
    assert_response :success
    assert_match "Extra fluffy pancakes", response.body
  end

  test "destroys a recipe" do
    recipe = recipes(:lentil_soup)

    assert_difference("Recipe.count", -1) { delete recipe_url(recipe) }
    assert_redirected_to recipes_url
    follow_redirect!
    assert_response :success
    assert_select "#recipes div[id^='recipe_']", count: Recipe.count
  end

  test "filters the list to quick recipes" do
    get recipes_url
    assert_response :success
    assert_select "form.recipe-filters"
    assert_select "select#quick"

    get recipes_url, params: { quick: "1" }
    assert_response :success
    assert_match recipes(:pancakes).title, response.body
    assert_no_match recipes(:lentil_soup).title, response.body
  end
end
