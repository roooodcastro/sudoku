# frozen_string_literal: true

module Sudoku
  module LogicSolver
    module Strategies
      class NakedPair < Sudoku::LogicSolver::Strategy
        def perform
          grid.units.each do |unit|
            unsolved_cells = unit.unsolved_cells
            next if unsolved_cells.empty?

            cells_with_pairs = naked_pairs(unsolved_cells)

            elimination_actions = process_pairs(cells_with_pairs, unsolved_cells)
            return elimination_actions if elimination_actions.present?
          end

          # If no cells were solved in this iteration, return an empty array of actions
          []
        end

        private

        def process_pairs(cells_with_pairs, unsolved_cells)
          cells_with_pairs.each do |pair, pair_cells|
            other_cells = unsolved_cells - pair_cells
            next if other_cells.blank?

            elimination_actions = create_elimination_actions(other_cells, pair_cells, pair)
            return elimination_actions if elimination_actions.present?
          end

          nil
        end

        def naked_pairs(cells)
          pairs_cells_hash = cells.each_with_object({}) do |cell, result|
            next if cell.candidates.size != 2

            pair = cell.candidates.to_a
            result[pair] ||= []
            result[pair] << cell
          end

          pairs_cells_hash.select { |_, pair_cells| pair_cells.size == 2 }
        end

        def create_elimination_actions(other_cells, pair_cells, pair)
          pair.each_with_object([]) do |candidate, result|
            action = perform_action(Action::ELIMINATE_CANDIDATE, pair_cells, other_cells, candidate)
            result << action if action.changed_grid?
          end
        end
      end
    end
  end
end
