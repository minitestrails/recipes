# test/models/step_test.rb
require "test_helper"

class StepTest < ActiveSupport::TestCase
  test "is valid" do
    assert steps(:preheat).valid?
  end

  test "rejects blank instruction" do
    step = Step.new(position: 1, instruction: "")
    assert_not step.valid?
    assert_includes step.errors[:instruction], "can't be blank"
  end

  test "rejects non-positive position" do
    step = Step.new(position: 0, instruction: "Mix gently.")
    assert_not step.valid?
    assert_includes step.errors[:position], "must be greater than 0"
  end
end
