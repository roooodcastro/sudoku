# frozen_string_literal: true

module Sudoku
  class Cell
    attr_reader :value, :frozen, :row, :col, :block, :peers, :grid_size, :candidates

    ROW_NAMES = ('A'..'I').to_a.freeze

    def initialize(value:, row:, col:, block:, grid:)
      @value      = value.to_i.zero? ? nil : value.to_i
      @frozen     = @value.present?
      @row        = row
      @col        = col
      @block      = block
      @peers      = []
      @grid_size  = grid.grid_size
      @candidates = value.to_i.zero? ? initial_candidates : Set.new
    end

    def solve(new_value)
      return false if frozen
      return false if valid_numbers.exclude?(new_value)

      changed = new_value != value
      @value = new_value
      changed
    end

    def solved?
      value.present?
    end

    def can_be?(value)
      return false if solved?

      candidates.include?(value)
    end

    def add_candidate(value)
      return if solved?

      candidates.add?(value)
    end

    def remove_candidate(value)
      return if solved?

      candidates.delete?(value)
    end

    def single_candidate?
      candidates.size == 1
    end

    def find_peers
      @peers = (row.cells + col.cells + block.cells) - [self]
    end

    def position_name
      row_name = ROW_NAMES[row.index]
      col_name = col.index + 1
      "#{row_name}#{col_name}"
    end

    def to_s
      value_name = value || '.'
      "<#{position_name}/#{value_name}/#{candidates.to_a.join}/#{object_id}>"
    end
    alias inspect to_s

    private

    def initial_candidates
      Set.new(1..grid_size)
    end

    def valid_numbers
      @valid_numbers ||= initial_candidates.to_a + [nil]
    end
  end
end
