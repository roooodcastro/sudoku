# frozen_string_literal: true

class Puzzle < ApplicationRecord
  self.implicit_order_column = :created_at

  validates :name, presence: true, uniqueness: true

  validate :validate_grid

  before_validation :ensure_random_name

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
