# frozen_string_literal: true

module Sudoku
  module LogicSolver
    module Actions
      class EliminateCandidate < Sudoku::LogicSolver::Action
        def to_s
          source_cell_names = source_cells.map(&:position_name).join(', ')
          affected_cell_names = affected_cells.map(&:position_name).join(', ')
          "Eliminate candidate '#{value}' from cell(s) #{affected_cell_names} because of #{strategy.name} in " \
            "cell(s) #{source_cell_names}"
        end

        private

        def up
          @affected_cells = target_cells.select do |cell|
            cell.remove_candidate(value)
          end
          affected_cells.any?
        end

        def down
          affected_cells.each { |cell| cell.add_candidate(value) }
        end
      end
    end
  end
end
