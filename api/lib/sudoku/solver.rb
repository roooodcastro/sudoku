# frozen_string_literal: true

module Sudoku
  class Solver
    class SolverNotFoundError < StandardError; end

    attr_reader :puzzle, :grid, :actions

    LOGIC     = :logic
    ALGORITHM = :algorithm

    SOLVERS = {
      LOGIC     => 'Sudoku::LogicSolver::Solver',
      ALGORITHM => 'Sudoku::AlgorithmSolver::Solver'
    }.freeze

    def self.for(solver: LOGIC)
      klass_name = SOLVERS[solver]
      raise SolverNotFoundError.new(message: solver) if klass_name.blank?

      klass_name.constantize
    end

    def initialize(puzzle)
      @puzzle  = puzzle
      @grid    = Sudoku::Grid.new(puzzle.definition)
      @actions = []
    end

    def solve
      raise NotImplementedError
    end
  end
end
