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
  end
end
