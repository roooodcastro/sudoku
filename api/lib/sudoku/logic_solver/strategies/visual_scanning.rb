# frozen_string_literal: true

module Sudoku
  module LogicSolver
    module Strategies
      class VisualScanning < Sudoku::LogicSolver::Strategy
        def perform # rubocop:disable Metrics/MethodLength
          solved_cells.each do |value, cell_group|
            scanned_cells = []

            elimination_actions = cell_group.map do |solved_cell|
              scanned_cells << solved_cell

              elimination_action = perform_elimination_action(value, scanned_cells)
              next unless elimination_action.changed_grid?

              solving_action = try_solving_solvable_cells(value, elimination_action)
              return [elimination_action, solving_action] if solving_action.present?

              elimination_action
            end.compact

            return elimination_actions.last if elimination_actions.present?
          end

          # If no cells were solved in this iteration, return an empty array of actions
          []
        end

        private

        def solved_cells
          grid.cells.select(&:solved?).group_by(&:value)
        end

        def try_solving_solvable_cells(value, elimination_action)
          grid.units.each do |unit|
            next if unit.value_solved?(value)

            solvable_cells = unit.cells.select { |cell| cell.can_be?(value) }
            next if solvable_cells.size != 1

            return perform_solving_action(solvable_cells.first, value, elimination_action)
          end

          nil
        end

        def perform_elimination_action(value, scanned_cells)
          peers = scanned_cells.map(&:peers).flatten.uniq
          perform_action(Action::ELIMINATE_CANDIDATE, scanned_cells, peers, value)
        end

        def perform_solving_action(solvable_cell, value, elimination_action)
          perform_action(Action::SOLVE_CELL, elimination_action.source_cells, solvable_cell, value)
        end
      end
    end
  end
end
