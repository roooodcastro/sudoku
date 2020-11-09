# frozen_string_literal: true

module Sudoku
  class Unit
    attr_reader :cells, :index

    def initialize(index)
      @cells = []
      @index = index
    end
  end
end
