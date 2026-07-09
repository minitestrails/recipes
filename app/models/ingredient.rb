class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true
  validates :quantity, numericality: { greater_than: 0 }, allow_nil: true
end
