# frozen_string_literal: true

module Sudoku
  module LogicSolver
    module Actions
      class SolveCell < Sudoku::LogicSolver::Action
        def to_s
          source_cell_names = source_cells.map(&:position_name).join(', ')
          target_cell_names = target_cells.map(&:position_name).join(', ')
          "Solve cell #{target_cell_names} with '#{value}' because of #{strategy.name} in " \
            "cell(s) #{source_cell_names}"
        end

        private

        def up
          @affected_cells = target_cells.select { |cell| cell.solve(value) }
          affected_cells.any?
        end

        def down
          affected_cells.map { |cell| cell.solve(nil) }
        end
      end
    end
  end
end
