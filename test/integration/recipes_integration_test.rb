# test/integration/recipes_integration_test.rb
require "test_helper"

class RecipesIntegrationTest < ActionDispatch::IntegrationTest
  test "lists recipes" do
    get recipes_url
    assert_response :success
    assert_match recipes(:pancakes).title, response.body
  end

  test "creates a recipe" do
    get new_recipe_url
    assert_response :success

    assert_difference("Recipe.count", 1) do
      post recipes_url, params: { recipe: { title: "Lentil soup" } }
    end

    assert_redirected_to recipe_url(Recipe.last)
    follow_redirect!
    assert_response :success
  end

  test "shows a recipe" do
    get recipe_url(recipes(:pancakes))
    assert_response :success
  end
end
