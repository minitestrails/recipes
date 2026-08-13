# app/controllers/ingredients_controller.rb
class IngredientsController < ApplicationController
  before_action :set_recipe, :set_ingredient

  def destroy
    @ingredient.destroy!
    render turbo_stream: turbo_stream.remove(@ingredient)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_ingredient
    @ingredient = @recipe.ingredients.find(params[:id])
  end
end
