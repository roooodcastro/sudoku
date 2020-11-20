# frozen_string_literal: true

module Sudoku
  module LogicSolver
    class Action
      class ActionNotFoundError < StandardError; end

      attr_reader :source_cells, :target_cells, :affected_cells, :strategy, :value, :performed

      ELIMINATE_CANDIDATE = :eliminate_candidate
      SOLVE_CELL          = :solve_cell

      ACTION_TYPES = {
        ELIMINATE_CANDIDATE => 'Sudoku::LogicSolver::Actions::EliminateCandidate',
        SOLVE_CELL          => 'Sudoku::LogicSolver::Actions::SolveCell'
      }.freeze

      def self.for(action_type:)
        klass_name = ACTION_TYPES[action_type]
        raise ActionNotFoundError.new(message: action_type) if klass_name.blank?

        klass_name.constantize
      end

      def initialize(strategy, source_cells, target_cells, value)
        @source_cells = Array(source_cells)
        @target_cells = Array(target_cells)
        @changed_grid = false
        @strategy     = strategy
        @value        = value
      end

      def will_change_grid?
        return false if performed

        # Perform a transactional check of the action to observe if it will change the grid
        will_change = up
        down
        will_change
      end

      def changed_grid?
        affected_cells.present?
      end

      def perform
        return if @performed

        @changed_grid = !up.nil?
        @performed = true
      end

      def rollback
        return unless @performed

        down
        @affected_cells = nil
        @changed_grid = false
        @performed = false
      end

      def is?(action_type)
        instance_of?(ACTION_TYPES[action_type].constantize)
      end

      private

      def up
        raise NotImplementedError
      end

      def down
        raise NotImplementedError
      end

      attr_reader :changed_grid
    end
  end
end
