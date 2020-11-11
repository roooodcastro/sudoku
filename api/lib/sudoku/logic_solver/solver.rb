# frozen_string_literal: true

module Sudoku
  module LogicSolver
    class Solver < Sudoku::Solver
      def solve
        until grid.solved?
          new_actions = apply_strategies

          # If the last step didn't solve any cells, then the solver can't handle the Sudoku puzzle given :(
          break if new_actions.blank?

          @actions += new_actions
          print_step(new_actions)
        end

        print_results
      end

      private

      def strategies
        @strategies ||= Strategy.all.map { |strategy_klass| strategy_klass.new(grid: grid) }
      end

      def apply_strategies
        strategies.each do |strategy|
          new_actions = strategy.perform
          return Array(new_actions) if new_actions.present?
        end

        # If no new actions were performed, it means that either the Sudoku is already solved or it cannot be solved.
        []
      end

      def print_step(new_actions)
        new_actions.each { |action| puts action }
        puts "Step ##{actions.size}, #{grid.solved_cells_count} clues found:"
        puts grid.print
      end

      def print_results
        if grid.solved?
          puts "\nSolution found in #{actions.size} steps!"
        else
          puts 'This puzzle is too hard for me :('
        end
      end
    end
  end
end
