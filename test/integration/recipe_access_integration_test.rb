# test/integration/recipe_access_integration_test.rb
require "test_helper"

class RecipeAccessIntegrationTest < ActionDispatch::IntegrationTest
  test "guest cannot create a recipe" do
    get new_recipe_url
    assert_redirected_to new_session_url

    assert_no_difference("Recipe.count") do
      post recipes_url, params: { recipe: { title: "Sneaky soup" } }
    end
    assert_redirected_to new_session_url
  end

  test "guest cannot edit a recipe" do
    recipe = recipes(:pancakes)
    original_title = recipe.title

    get edit_recipe_url(recipe)
    assert_redirected_to new_session_url

    patch recipe_url(recipe), params: { recipe: { title: "Hacked title" } }
    assert_redirected_to new_session_url
    assert_equal original_title, recipe.reload.title
  end

  test "guest cannot destroy a recipe" do
    recipe = recipes(:lentil_soup)

    assert_no_difference("Recipe.count") { delete recipe_url(recipe) }
    assert_redirected_to new_session_url
  end

  test "signed-in user sees new recipe on the list" do
    sign_in_as users(:alice)

    get recipes_url
    assert_response :success
    assert_select "a", text: "New recipe"
    assert_select "button", text: "Destroy this recipe"
  end

  test "signed-in user sees edit and destroy on show" do
    sign_in_as users(:alice)

    get recipe_url(recipes(:pancakes))
    assert_response :success
    assert_select "a", text: "Edit this recipe"
    assert_select "button", text: "Destroy this recipe"
    assert_select "button", text: "Remove"
  end

  test "non-owner cannot update a recipe" do
    sign_in_as users(:bob)
    recipe = recipes(:pancakes)

    get edit_recipe_url(recipe)
    assert_redirected_to recipe_url(recipe)
    follow_redirect!
    assert_match "You are not authorized to modify this recipe.", response.body

    patch recipe_url(recipe), params: { recipe: { title: "Hacked pancakes" } }
    assert_redirected_to recipe_url(recipe)
    follow_redirect!
    assert_match "You are not authorized to modify this recipe.", response.body
    assert_not_equal "Hacked pancakes", recipe.reload.title
  end
end
