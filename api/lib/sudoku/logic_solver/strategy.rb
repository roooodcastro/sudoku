# frozen_string_literal: true

module Sudoku
  module LogicSolver
    class Strategy
      class StrategyNotFoundError < StandardError; end

      attr_reader :grid

      STRATEGY_TYPES = {
        visual_scanning: 'Sudoku::LogicSolver::Strategies::VisualScanning',
        naked_single:    'Sudoku::LogicSolver::Strategies::NakedSingle'
      }.freeze

      def self.all
        @all ||= STRATEGY_TYPES.keys.map { |strategy| self.for(strategy: strategy) }
      end

      def self.for(strategy:)
        klass_name = STRATEGY_TYPES[strategy]
        raise StrategyNotFoundError.new(message: strategy) if klass_name.blank?

        klass_name.constantize
      end

      def initialize(grid:)
        @grid = grid
      end

      def perform
        raise NotImplementedError
      end

      def name
        self.class.name.demodulize.titleize
      end

      private

      def perform_action(action_type, source_cells, target_cells, value)
        action = Sudoku::LogicSolver::Action
                 .for(action_type: action_type)
                 .new(self, source_cells, target_cells, value)
        action.perform
        action
      end
    end
  end
end
