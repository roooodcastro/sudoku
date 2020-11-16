# frozen_string_literal: true

module Sudoku
  module LogicSolver
    module Strategies
      class HiddenSingle < Sudoku::LogicSolver::Strategy
        def perform
          grid.units.each do |unit|
            unsolved_cells = unit.unsolved_cells
            next if unsolved_cells.empty?

            grid.numbers.each do |value|
              possible_cells = unsolved_cells.select { |cell| cell.can_be?(value) }
              next if possible_cells.size != 1

              # If a number value can only be put in one cell of a row, col or block, that cell must have this value
              return perform_action(Action::SOLVE_CELL, unsolved_cells, possible_cells.first, value)
            end
          end

          # If no cells were solved in this iteration, return an empty array of actions
          []
        end
      end
    end
  end
end
