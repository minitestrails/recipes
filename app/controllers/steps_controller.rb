# app/controllers/steps_controller.rb
class StepsController < ApplicationController
  before_action :set_recipe, :set_step

  def destroy
    authorize! @step

    @step.destroy!
    render turbo_stream: turbo_stream.remove(@step)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_step
    @step = @recipe.steps.find(params[:id])
  end
end
