# frozen_string_literal: true

RSpec.describe Sudoku::Grid::Validator, type: :model do
  let(:grid) { Sudoku::Grid.new(definition) }

  describe '#valid?' do
    subject(:validation_result) { grid.valid? }

    let(:errors) do
      validation_result
      grid.errors
    end

    let(:formatted_errors) do
      validation_result
      grid.formatted_errors
    end

    context 'when the puzzle is valid' do
      # 0 0 │ 0 3
      # 0 0 │ 0 2
      # ────┼────
      # 3 0 │ 0 0
      # 4 0 │ 0 0
      let(:definition) { '0003000230004000' }

      it { is_expected.to be_truthy }
      it { expect(errors).to be_empty }
    end

    context 'when the puzzle is invalid' do
      let(:definition) { '001002003' }

      it 'multiple calls to valid? should not stack errors' do
        grid.valid?
        grid.valid?
        grid.valid?
        expect(errors.size).to eq 1
      end
    end

    context 'when the puzzle has an invalid length' do
      let(:definition) { '001002003' }

      it { is_expected.to be_falsey }
      it { expect(errors).to include(name: :invalid_length, length: 9, valid_lengths: '16, 81') }
      it { expect(formatted_errors).to include('Puzzle has an invalid length of 9. Valid lengths are: 16, 81') }
    end

    context 'when the puzzle is nil' do
      let(:definition) { nil }

      it { is_expected.to be_falsey }
      it { expect(errors).to include(name: :empty_puzzle) }
      it { expect(formatted_errors).to include('Puzzle is empty!') }
    end

    context 'when the puzzle contains invalid characters' do
      # 9 0 │ 0 3
      # 0 0 │ 0 2
      # ────┼────
      # 3 0 │ 0 0
      # 4 0 │ 0 Z
      let(:definition) { '9003000230004000' }

      it { is_expected.to be_falsey }
      it { expect(errors).to include(name: :invalid_digits, digits: '9', valid_digits: '0, 1, 2, 3, 4') }
      it { expect(formatted_errors).to include('Puzzle has invalid digits: 9. Valid digits are: 0, 1, 2, 3, 4') }
    end

    context 'when one of the rows has duplicate digits' do
      # 0 3 │ 0 3
      # 0 0 │ 0 2
      # ────┼────
      # 3 0 │ 0 0
      # 4 0 │ 0 0
      let(:definition) { '0303000230004000' }

      it { is_expected.to be_falsey }
      it { expect(errors).to include(name: :duplicate_in_row, digit: 3, row: 'A') }
      it { expect(formatted_errors).to include('Digit 3 repeats in row A. It must be unique in that row') }
    end

    context 'when one of the columns has duplicate digits' do
      # 0 1 │ 0 3
      # 0 0 │ 0 2
      # ────┼────
      # 0 1 │ 0 0
      # 4 0 │ 0 0
      let(:definition) { '0103000231004000' }

      it { is_expected.to be_falsey }
      it { expect(errors).to include(name: :duplicate_in_col, digit: 1, col: '2') }
      it { expect(formatted_errors).to include('Digit 1 repeats in column 2. It must be unique in that column') }
    end

    context 'when one of the units has duplicate digits' do
      # 0 0 │ 0 3
      # 0 0 │ 0 2
      # ────┼────
      # 3 4 │ 0 0
      # 4 0 │ 0 0
      let(:definition) { '0003000234004000' }

      it { is_expected.to be_falsey }
      it { expect(errors).to include(name: :duplicate_in_block, digit: 4, block: '3') }
      it { expect(formatted_errors).to include('Digit 4 repeats in block 3. It must be unique in that block') }
    end

    context 'when one of the rows has multiple duplicate digits' do
      # 1 3 │ 1 3
      # 0 0 │ 0 2
      # ────┼────
      # 3 0 │ 0 0
      # 4 0 │ 0 0
      let(:definition) { '1313000230004000' }

      it { is_expected.to be_falsey }
      it { expect(errors).to include(name: :duplicate_in_row, digit: 1, row: 'A') }
      it { expect(errors).to include(name: :duplicate_in_row, digit: 3, row: 'A') }
      it { expect(formatted_errors).to include('Digit 1 repeats in row A. It must be unique in that row') }
      it { expect(formatted_errors).to include('Digit 3 repeats in row A. It must be unique in that row') }
    end
  end
end
