# frozen_string_literal: true

module Sudoku
  module LogicSolver
    class Solver < Sudoku::Solver
      def solve
        puts grid.print
      end
    end
  end
end
