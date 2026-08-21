# app/policies/step_policy.rb
class StepPolicy < ApplicationPolicy
  def destroy?
    recipe_owner?
  end

  private

  def recipe_owner?
    owner?(another_record: record.recipe)
  end
end
