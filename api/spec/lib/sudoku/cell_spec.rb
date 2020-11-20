# frozen_string_literal: true

RSpec.describe Sudoku::Cell, type: :model do
  let(:cell) { described_class.new(value: initial_value, row: row, col: col, block: block, grid: grid) }

  let(:initial_value) { 9 }
  let(:row) { instance_double(Sudoku::Unit, name: 'B') }
  let(:col) { instance_double(Sudoku::Unit, name: '3') }
  let(:block) { instance_double(Sudoku::Unit, name: '4') }
  let(:grid) { instance_double(Sudoku::Grid, grid_size: 9) }

  describe 'Ivar assignment' do
    it { expect(cell.instance_variable_get(:@value)).to eq initial_value }
    it { expect(cell.instance_variable_get(:@row)).to eq row }
    it { expect(cell.instance_variable_get(:@col)).to eq col }
    it { expect(cell.instance_variable_get(:@block)).to eq block }
    it { expect(cell.instance_variable_get(:@grid_size)).to eq grid.grid_size }

    context 'when value is initially nil' do
      let(:initial_value) { nil }

      it { expect(cell.instance_variable_get(:@candidates)).to eq Set.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }
    end

    context 'when value is initially a valid number' do
      let(:initial_value) { 4 }

      it { expect(cell.instance_variable_get(:@candidates)).to eq Set.new }
    end
  end

  describe '#to_s' do
    subject { cell.to_s }

    context 'when value is blank' do
      let(:initial_value) { nil }

      it { is_expected.to eq "<B3/./123456789/#{cell.object_id}>" }
    end

    context 'when value is present' do
      let(:initial_value) { 5 }

      it { is_expected.to eq "<B3/5//#{cell.object_id}>" }
    end
  end

  describe '#solve' do
    subject(:solve_result) { cell.solve(value) }

    context 'when the cell is frozen' do
      let(:initial_value) { 6 }
      let(:value) { 1 }

      it { is_expected.to be_falsey }
      it { expect { solve_result }.not_to(change { cell.value }) }
    end

    context 'when the cell is not frozen' do
      let(:initial_value) { nil }

      context 'with a valid value different from the previous value' do
        let(:value) { 3 }

        it { is_expected.to be_truthy }
        it { expect { solve_result }.to change { cell.value }.from(nil).to(3) }
      end

      context 'with a valid value that is the same as before' do
        let(:value) { 6 }

        before { cell.instance_variable_set(:@value, 6) }

        it { is_expected.to be_falsey }
        it { expect { solve_result }.not_to(change { cell.value }) }
      end

      context 'with an invalid value' do
        let(:value) { -1 }

        it { is_expected.to be_falsey }
        it { expect { solve_result }.not_to(change { cell.value }) }
      end

      context 'with nil' do
        let(:value) { nil }

        before { cell.instance_variable_set(:@value, 6) }

        it { is_expected.to be_truthy }
        it { expect { solve_result }.to change { cell.value }.from(6).to(nil) }
      end
    end
  end
end
