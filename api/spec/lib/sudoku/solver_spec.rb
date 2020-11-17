# frozen_string_literal: true

RSpec.describe Sudoku::Solver, type: :model do
  let(:solver) { described_class.new(puzzle) }

  let(:puzzle) { instance_double(Puzzle, definition: '1234') }

  describe '#for' do
    subject { described_class.for(solver: solver_type) }

    context 'when the solver is Algorithm' do
      let(:solver_type) { Sudoku::Solver::ALGORITHM }

      it { is_expected.to eq Sudoku::AlgorithmSolver::Solver }
    end

    context 'when the solver is Logic' do
      let(:solver_type) { Sudoku::Solver::LOGIC }

      it { is_expected.to eq Sudoku::LogicSolver::Solver }
    end
  end

  describe 'Ivar assignment' do
    let(:grid) { instance_double(Sudoku::Grid) }

    before { allow(Sudoku::Grid).to receive(:new).with('1234').and_return(grid) }

    it { expect(solver.instance_variable_get(:@puzzle)).to eq puzzle }
    it { expect(solver.instance_variable_get(:@grid)).to eq grid }
    it { expect(solver.instance_variable_get(:@actions)).to eq [] }
  end

  describe '#solve' do
    it { expect { solver.solve }.to raise_error(NotImplementedError) }
  end
end
