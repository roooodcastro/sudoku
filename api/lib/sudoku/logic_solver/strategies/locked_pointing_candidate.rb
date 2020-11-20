# frozen_string_literal: true

module Sudoku
  module LogicSolver
    module Strategies
      class LockedPointingCandidate < Sudoku::LogicSolver::Strategy
        def perform
          grid.blocks.each_value do |block|
            unsolved_cells = block.unsolved_cells
            next if unsolved_cells.empty?

            elimination_action = process_grid_block(unsolved_cells)
            return elimination_action if elimination_action.present?
          end

          # If no cells were solved in this iteration, return an empty array of actions
          []
        end

        private

        def process_grid_block(unsolved_cells)
          grid.numbers.each do |value|
            possible_cells = possible_cells_for_value(unsolved_cells, value)
            target_unit    = find_pointed_unit(possible_cells)
            next if target_unit.blank?

            target_cells       = target_unit.cells - possible_cells
            elimination_action = perform_action(Action::ELIMINATE_CANDIDATE, possible_cells, target_cells, value)
            return elimination_action if elimination_action.changed_grid?
          end

          nil
        end

        def find_pointed_unit(cells)
          return if cells.size < 2

          cells_same_row = cells.map(&:row).uniq.size == 1
          cells_same_col = cells.map(&:col).uniq.size == 1

          # If all possible cells are in the same row or col, that value can be eliminated from the other cells in
          # that row/col
          return if !cells_same_row && !cells_same_col

          cells_same_row ? cells.first.row : cells.first.col
        end

        def possible_cells_for_value(cells, value)
          cells.select { |cell| cell.can_be?(value) }
        end
      end
    end
  end
end
