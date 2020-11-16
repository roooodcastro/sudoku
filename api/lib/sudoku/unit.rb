# frozen_string_literal: true

module Sudoku
  class Unit
    attr_reader :cells, :index

    def initialize(index)
      @cells = []
      @index = index
    end

    def has?(value)
      cells.map(&:value).include?(value)
    end

    def unsolved_cells
      cells.reject(&:solved?)
    end
  end
end
