# app/models/recipe.rb
class Recipe < ApplicationRecord
  validates :title, presence: true
  validates :prep_time, numericality: { greater_than: 0 }, allow_nil: true
  validates :servings, numericality: { greater_than: 0 }, allow_nil: true

  validate :description_cannot_be_whitespace_only

  scope :quick, -> { where(prep_time: ...30) }

  before_validation :strip_title_whitespace, if: -> { title.present? }

  def printable?
    title.present? && servings.present? && servings.positive?
  end

  private

  def description_cannot_be_whitespace_only
    return if description.nil? || description.empty?
    return if description.strip.length.positive?

    errors.add(:description, "can't be only spaces")
  end

  def strip_title_whitespace
    self.title = title.strip
  end
end
