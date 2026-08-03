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

  test "shows ingredients and steps on the recipe page" do
    get recipe_url(recipes(:pancakes))
    assert_response :success
    assert_match recipes(:pancakes).title, response.body
    assert_select "h2", "Ingredients"
    assert_match "Salt (1 pinch)", response.body
    assert_match "Flour (2 cups)", response.body
    assert_select "h2", "Steps"
    assert_match steps(:preheat).instruction, response.body
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

  test "creates a recipe with an ingredient and a step" do
    get new_recipe_url
    assert_response :success
    assert_match "New recipe", response.body
    assert_select "h2", "Ingredients"
    assert_select "h2", "Steps"

    assert_difference %w[Recipe.count Ingredient.count Step.count], 1 do
      post recipes_url,
           params: {
             recipe: {
               title: "Tomato soup",
               ingredients_attributes: {
                 "0" => {
                   name: "Tomatoes",
                   quantity: "400",
                   unit: "g"
                 }
               },
               steps_attributes: {
                 "0" => {
                   position: "1",
                   instruction: "Simmer until the tomatoes soften"
                 }
               }
             }
           }
    end
    assert_redirected_to recipe_url(Recipe.last)
    follow_redirect!
    assert_response :success
    assert_match "Tomatoes (400 g)", response.body
    assert_match "Simmer until the tomatoes soften", response.body
  end

  test "does not create a recipe with invalid data" do
    assert_no_difference("Recipe.count") do
      post recipes_url, params: { recipe: { title: "" } }
    end
    assert_response :unprocessable_entity
    assert_match /prohibited this recipe from being saved/i, response.body
    assert_select "h1", "New recipe"
  end

  test "does not create a recipe with invalid ingredient" do
    assert_no_difference %w[Recipe.count Ingredient.count] do
      post recipes_url,
           params: {
             recipe: {
               title: "Tomato soup",
               ingredients_attributes: {
                 "0" => {
                   name: "Tomatoes",
                   quantity: "-1",
                   unit: "cups"
                 }
               }
             }
           }
    end
    assert_response :unprocessable_entity
    assert_match /prohibited this recipe from being saved/i, response.body
    assert_match /ingredients quantity must be greater than 0/i, response.body
    assert_select "h1", "New recipe"
  end

  test "does not create a recipe with invalid step" do
    assert_no_difference %w[Recipe.count Step.count] do
      post recipes_url,
           params: {
             recipe: {
               title: "Tomato soup",
               steps_attributes: {
                 "0" => {
                   position: "1",
                   instruction: ""
                 }
               }
             }
           }
    end
    assert_response :unprocessable_entity
    assert_match /prohibited this recipe from being saved/i, response.body
    assert_select "li", text: /steps instruction can't be blank/i
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

  test "adds an ingredient and a step when editing a recipe" do
    recipe = recipes(:pancakes)

    assert_difference %w[Ingredient.count Step.count], 1 do
      patch recipe_url(recipe),
            params: {
              recipe: {
                title: recipe.title,
                ingredients_attributes: {
                  "0" => {
                    name: "Pepper",
                    quantity: "1",
                    unit: "pinch"
                  }
                },
                steps_attributes: {
                  "0" => {
                    position: "2",
                    instruction: "Flip and serve."
                  }
                }
              }
            }
    end
    assert_redirected_to recipe_url(recipe)
    follow_redirect!
    assert_response :success
    assert_match "Pepper (1 pinch)", response.body
    assert_match "Flip and serve.", response.body
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

  test "removes existing ingredients and steps when updating a recipe" do
    recipe = recipes(:pancakes)
    salt = ingredients(:salt)
    preheat = steps(:preheat)

    assert_difference %w[Ingredient.count Step.count], -1 do
      patch recipe_url(recipe),
            params: {
              recipe: {
                title: recipe.title,
                ingredients_attributes: {
                  "0" => {
                    id: salt.id,
                    _destroy: "1"
                  }
                },
                steps_attributes: {
                  "0" => {
                    id: preheat.id,
                    _destroy: "1"
                  }
                }
              }
            }
    end

    assert_redirected_to recipe_url(recipe)
    follow_redirect!
    assert_response :success
    assert_no_match salt.name, response.body
    assert_no_match preheat.instruction, response.body
    assert_match "Flour (2 cups)", response.body
  end

  test "removes ingredients and steps from the detail page" do
    recipe = recipes(:pancakes)
    salt = ingredients(:salt)
    preheat = steps(:preheat)

    assert_difference ["Ingredient.count", "Step.count"], -1 do
      delete recipe_ingredient_url(recipe, salt), as: :turbo_stream
      delete recipe_step_url(recipe, preheat), as: :turbo_stream
    end

    get recipe_url(recipe)
    assert_response :success
    assert_no_match salt.name, response.body
    assert_no_match preheat.instruction, response.body
    assert_match "Flour (2 cups)", response.body
  end
end
