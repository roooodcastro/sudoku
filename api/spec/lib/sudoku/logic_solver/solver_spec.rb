# frozen_string_literal: true

RSpec.describe Sudoku::LogicSolver::Solver, type: :model do
  let(:solver) { described_class.new(puzzle) }

  # Example 2x2 puzzle:
  #
  # Initial:   Solved:
  # 0 0 0 3    2 4 1 3
  # 0 0 0 2    1 3 4 2
  # 3 0 0 0    3 1 2 4
  # 4 0 0 0    4 2 3 1
  #
  # Solution path:
  #
  # Eliminate candidate '3' from cell(s) C2, C3, B1, D2 because of Visual Scanning in cell(s) A4, C1
  # Solve cell B2 with '3' because of Visual Scanning in cell(s) A4, C1
  # Eliminate candidate '2' from cell(s) B1, B3, C4, D4, A3 because of Visual Scanning in cell(s) B4
  # Solve cell A1 with '2' because of Visual Scanning in cell(s) B4
  # Eliminate candidate '2' from cell(s) A2 because of Visual Scanning in cell(s) A1, B4
  # Eliminate candidate '4' from cell(s) D2, D3, D4, B1, C2 because of Visual Scanning in cell(s) D1
  # Solve cell B3 with '4' because of Visual Scanning in cell(s) D1
  # Eliminate candidate '4' from cell(s) A3, C3 because of Visual Scanning in cell(s) B3
  # Solve cell A2 with '4' because of Visual Scanning in cell(s) B3
  # Solve cell A3 with '1' because of Naked Single in cell(s) A3
  # Eliminate candidate '1' from cell(s) C3, D3 because of Visual Scanning in cell(s) A3
  # Solve cell B1 with '1' because of Visual Scanning in cell(s) A3
  # Solve cell C3 with '2' because of Naked Single in cell(s) C3
  # Eliminate candidate '2' from cell(s) C2, D3 because of Visual Scanning in cell(s) A1, B4, C3
  # Solve cell D2 with '2' because of Visual Scanning in cell(s) A1, B4, C3
  # Solve cell C2 with '1' because of Naked Single in cell(s) C2
  # Eliminate candidate '1' from cell(s) C4 because of Visual Scanning in cell(s) A3, B1, C2
  # Solve cell D4 with '1' because of Visual Scanning in cell(s) A3, B1, C2
  # Solve cell C4 with '4' because of Naked Single in cell(s) C4
  # Solve cell D3 with '3' because of Naked Single in cell(s) D3
  #
  let(:puzzle) { instance_double(Puzzle, definition: '0003000230004000') }

  describe '#solve' do
    subject(:solution) { solver.solve }

    context 'when the puzzle is solvable' do
      it { expect(solution.size).to eq 20 }
      it { expect(solution.first).to be_a(Sudoku::LogicSolver::Action) }
      it { expect { solution }.to change { solver.grid.solved_cells_count }.from(4).to(16) }
    end

    context 'when the puzzle is unsolvable' do
      before { allow(Sudoku::LogicSolver::Strategy).to receive(:all).and_return([]) }

      it { is_expected.to eq [] }
      it { expect { solution }.not_to(change { solver.grid.solved_cells_count }) }
    end
  end
end
