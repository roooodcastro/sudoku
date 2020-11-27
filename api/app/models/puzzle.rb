# frozen_string_literal: true

class Puzzle < ApplicationRecord
  extend FriendlyId

  self.implicit_order_column = :created_at

  before_validation :ensure_random_name
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true

  validate :validate_grid

  def sudoku_grid
    @sudoku_grid ||= Sudoku::Grid.new(definition)
  end

  private

  def ensure_random_name
    return if persisted? || name.present?

    self.name = "#{Faker::Creature::Animal.name}-#{Faker::Internet.slug}".titleize

    return unless self.class.exists?(name: name)

    # Retry to get an unique name
    ensure_random_name
  end

  def validate_grid
    return if sudoku_grid.valid?

    sudoku_grid.formatted_errors.each { |error| errors.add(:base, error) }
  end
end
