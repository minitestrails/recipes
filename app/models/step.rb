class Step < ApplicationRecord
  belongs_to :recipe

  validates :instruction, presence: true
  validates :position, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
end
