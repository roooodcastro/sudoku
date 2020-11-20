# frozen_string_literal: true

module Sudoku
  module LogicSolver
    module Strategies
      class HiddenPair < Sudoku::LogicSolver::Strategy
        def perform
          grid.units.each do |unit|
            unsolved_cells = unit.unsolved_cells
            next if unsolved_cells.empty?

            hidden_pairs(unsolved_cells).each do |pair, cells|
              elimination_actions = process_hidden_pair(pair, cells, unsolved_cells)
              return elimination_actions if elimination_actions.present?
            end
          end

          # If no cells were solved in this iteration, return an empty array of actions
          []
        end

        private

        def process_hidden_pair(pair, pair_cells, unsolved_cells)
          other_cells = unsolved_cells - pair_cells
          return if other_cells.blank? || candidate_possible_outside_pair?(other_cells, pair)

          create_elimination_actions(pair_cells, pair).presence
        end

        def hidden_pairs(cells)
          pairs_cells_hash = cells.each_with_object({}) do |cell, result|
            cell.candidates.to_a.combination(2).each do |pair|
              result[pair] ||= []
              result[pair] << cell
            end
          end

          pairs_cells_hash.select { |_, pair_cells| pair_cells.size == 2 }
        end

        def create_elimination_actions(pair_cells, pair)
          eliminated_candidates = pair_cells.map(&:candidates).map(&:to_a).flatten.uniq - pair

          eliminated_candidates.each_with_object([]) do |candidate, result|
            action = perform_action(Action::ELIMINATE_CANDIDATE, pair_cells, pair_cells, candidate)
            result << action if action.changed_grid?
          end
        end

        def candidate_possible_outside_pair?(other_cells, pair)
          other_cells.any? do |cell|
            pair.any? { |candidate| cell.can_be?(candidate) }
          end
        end
      end
    end
  end
end
