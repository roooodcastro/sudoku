# frozen_string_literal: true

module Sudoku
  class Cell
    attr_reader :value, :row, :col, :block

    ROW_NAMES = ('A'..'I').to_a.freeze

    def initialize(value:, row:, col:, block:)
      @value = value.to_i.zero? ? nil : value.to_i
      @row   = row
      @col   = col
      @block = block
    end

    def to_s
      row_name = ROW_NAMES[row.index]
      col_name = col.index + 1
      value_name = value || '.'
      "<#{row_name}#{col_name}/#{value_name}/#{object_id}>"
    end
    alias inspect to_s
  end
end
