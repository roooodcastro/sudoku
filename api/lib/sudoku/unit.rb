# frozen_string_literal: true

module Sudoku
  class Unit
    attr_reader :cells, :index, :type

    ROW_NAMES = ('A'..'I').to_a.freeze

    def initialize(index, type)
      @cells = []
      @index = index
      @type  = type
    end

    def value_solved?(value)
      cells.map(&:value).include?(value)
    end

    def unsolved_cells
      cells.reject(&:solved?)
    end

    def name
      return ROW_NAMES[index] if type == :row

      (index + 1).to_s
    end
  end
end
