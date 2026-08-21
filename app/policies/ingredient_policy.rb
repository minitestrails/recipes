# app/policies/ingredient_policy.rb
class IngredientPolicy < ApplicationPolicy
  def destroy?
    recipe_owner?
  end

  private

  def recipe_owner?
    owner?(another_record: record.recipe)
  end
end
