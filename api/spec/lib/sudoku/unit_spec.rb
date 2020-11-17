# frozen_string_literal: true

RSpec.describe Sudoku::Unit, type: :model do
  let(:unit) { described_class.new(index) }

  let(:index) { 0 }

  describe 'Ivar assignment' do
    it { expect(unit.instance_variable_get(:@cells)).to eq [] }
    it { expect(unit.instance_variable_get(:@index)).to eq index }
  end

  describe '#value_solved?' do
    subject { unit.value_solved?(value) }

    let(:cell_1) { instance_double(Sudoku::Cell, value: 1) }
    let(:cell_2) { instance_double(Sudoku::Cell, value: 2) }

    before { unit.instance_variable_set(:@cells, [cell_1, cell_2]) }

    context 'when the unit has a cell with the value' do
      let(:value) { 1 }

      it { is_expected.to be_truthy }
    end

    context 'when the unit does not have a cell with the value' do
      let(:value) { 3 }

      it { is_expected.to be_falsey }
    end
  end

  describe '#unsolved_cells' do
    subject { unit.unsolved_cells }

    let(:cell_1) { instance_double(Sudoku::Cell, solved?: true) }
    let(:cell_2) { instance_double(Sudoku::Cell, solved?: false) }

    before { unit.instance_variable_set(:@cells, [cell_1, cell_2]) }

    it { is_expected.to eq [cell_2] }
  end
end
