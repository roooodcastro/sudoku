# frozen_string_literal: true

RSpec.describe Sudoku::Cell, type: :model do
  let(:cell) { described_class.new(value: value, row: row, col: col, block: block) }

  let(:value) { 9 }
  let(:row) { instance_double(Sudoku::Unit, index: 1) }
  let(:col) { instance_double(Sudoku::Unit, index: 2) }
  let(:block) { instance_double(Sudoku::Unit, index: 3) }

  describe 'Ivar assignment' do
    it { expect(cell.instance_variable_get(:@value)).to eq value }
    it { expect(cell.instance_variable_get(:@row)).to eq row }
    it { expect(cell.instance_variable_get(:@col)).to eq col }
    it { expect(cell.instance_variable_get(:@block)).to eq block }
  end

  describe 'to_s' do
    subject { cell.to_s }

    context 'when value is blank' do
      let(:value) { nil }

      it { is_expected.to eq "<B3/./#{cell.object_id}>" }
    end

    context 'when value is present' do
      let(:value) { 5 }

      it { is_expected.to eq "<B3/5/#{cell.object_id}>" }
    end
  end
end
