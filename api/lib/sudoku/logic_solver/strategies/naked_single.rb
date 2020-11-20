# frozen_string_literal: true

module Sudoku
  module LogicSolver
    module Strategies
      class NakedSingle < Sudoku::LogicSolver::Strategy
        def perform
          unsolved_cells.each do |cell|
            next unless cell.single_candidate?

            # If a cell only has a single possible candidate, it can be immediatelly solved with that candidate
            return perform_action(Action::SOLVE_CELL, cell, cell, cell.candidates.first)
          end

          # If no cells were solved in this iteration, return an empty array of actions
          []
        end

        private

        def unsolved_cells
          grid.cells.reject(&:solved?)
        end
      end
    end
  end
end
