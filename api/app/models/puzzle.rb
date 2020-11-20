# frozen_string_literal: true

class Puzzle < ApplicationRecord
  self.implicit_order_column = :created_at

  validate :validate_grid

  def sudoku_grid
    @sudoku_grid ||= Sudoku::Grid.new(definition)
  end

  private

  def validate_grid
    return if sudoku_grid.valid?

    sudoku_grid.formatted_errors.each { |error| errors.add(:base, error) }
  end
end
