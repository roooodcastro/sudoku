# frozen_string_literal: true

require './cell'

class Grid
  attr_reader :cells

  def initialize(game_string)
    numbers = game_string.chars.map(&:to_i)
    @cells = numbers.each_with_index.map { |number, index| Cell.new(number, index) }
  end

  def empty_cells
    cells.select(&:empty?)
  end

  def column(index)
    index = index.column if index.is_a? Cell
    columns[index]
  end

  def row(index)
    index = index.row if index.is_a? Cell
    rows[index]
  end

  def sub_grid(index)
    index = index.sub_grid if index.is_a? Cell
    sub_grids[index]
  end

  private

  def columns
    @columns ||= (0..8).map { |index| cells.select { |cell| cell.column == index } }
  end

  def rows
    @rows ||= (0..8).map { |index| cells.select { |cell| cell.row == index } }
  end

  def sub_grids
    @sub_grids ||= (0..8).map { |index| cells.select { |cell| cell.sub_grid == index } }
  end
end
