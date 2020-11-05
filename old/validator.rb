# frozen_string_literal: true

class Validator
  attr_reader :game

  def self.validate(game)
    validator = Validator.new(game)
    validator.validate
  end

  def initialize(game)
    @game = game.strip.chars
  end

  def valid?
    all_sequences.all? { |sequence| valid_sequence?(sequence) }
  end

  def complete?
    all_sequences.all? { |sequence| complete_sequence?(sequence) }
  end

  def valid_sequence?(sequence)
    except_empty = sequence - ['0']
    except_empty.size == except_empty.uniq.size
  end

  def complete_sequence?(sequence)
    except_empty = sequence - ['0']
    except_empty.size == 9 && except_empty.size == except_empty.uniq.size
  end

  def row(row_index)
    game[(row_index * 9)..(row_index * 9 + 8)]
  end

  def column(column_index)
    game.select.with_index { |_, index| index % 9 == column_index }
  end

  def sub_grid(sub_grid_index)
    sub_row_index = sub_grid_index / 3
    sub_col_index = sub_grid_index % 3

    sub_rows = rows[(sub_row_index * 3)..(sub_row_index * 3 + 2)]
    sub_rows.map { |sub_row| sub_row[(sub_col_index * 3)..(sub_col_index * 3 + 2)] }.flatten
  end

  def rows
    @rows ||= (0..8).map { |index| row(index) }
  end

  def columns
    @columns ||= (0..8).map { |index| column(index) }
  end

  def sub_grids
    @sub_grids ||= (0..8).map { |index| sub_grid(index) }
  end

  def all_sequences
    @all_sequences ||= rows + columns + sub_grids
  end

  def column_of(index)
    index % 9
  end

  def row_of(index)
    index / 9
  end

  def grid_of(index)
    ((row_of(index) / 3) * 3) + (column_of(index) / 3)
  end
end
