# frozen_string_literal: true

RSpec.describe Sudoku::Grid, type: :model do
  let(:grid) { described_class.new(puzzle_definition) }
  let(:puzzle_definition) { '1234567898765432' }

  describe 'Ivar assignment' do
    it { expect(grid.instance_variable_get(:@grid_size)).to eq 4 }
    it { expect(grid.instance_variable_get(:@sub_grid_size)).to eq 2 }
  end

  describe '#build_grid' do
    grid_size = 4

    describe 'rows' do
      subject(:rows) { grid.rows }

      it { is_expected.to be_a Hash }
      it { expect(rows.size).to eq grid_size }

      grid_size.times do |row_index|
        it("expect row #{row_index} to be a Unit") { expect(rows[row_index]).to be_a(Sudoku::Unit) }

        grid_size.times do |cell_index|
          it "expect row #{row_index}, cell #{cell_index} to link back to row" do
            expect(rows[row_index].cells[cell_index].row).to eq rows[row_index]
          end
        end
      end
    end

    describe 'cols' do
      subject(:cols) { grid.cols }

      it { is_expected.to be_a Hash }
      it { expect(cols.size).to eq grid_size }

      grid_size.times do |col_index|
        it("expect col #{col_index} to be a Unit") { expect(cols[col_index]).to be_a(Sudoku::Unit) }

        grid_size.times do |cell_index|
          it "expect col #{col_index}, cell #{cell_index} to link back to col" do
            expect(cols[col_index].cells[cell_index].col).to eq cols[col_index]
          end
        end
      end
    end

    describe 'blocks' do
      subject(:blocks) { grid.blocks }

      it { is_expected.to be_a Hash }
      it { expect(blocks.size).to eq grid_size }

      grid_size.times do |block_index|
        it("expect block #{block_index} to be a Unit") { expect(blocks[block_index]).to be_a(Sudoku::Unit) }

        grid_size.times do |cell_index|
          it "expect block #{block_index}, cell #{cell_index} to link back to block" do
            expect(blocks[block_index].cells[cell_index].block).to eq blocks[block_index]
          end
        end
      end
    end

    describe 'cells' do
      subject(:cells) { grid.cells }

      it { expect(cells.size).to eq grid_size**2 }

      # Couldn't find a good way to parameterise this :(
      it 'sets all cells row, col and block indices correctly', :aggregate_failures do # rubocop:disable RSpec/ExampleLength
        expect(cells[0].row.index).to eq 0
        expect(cells[1].row.index).to eq 0
        expect(cells[2].row.index).to eq 0
        expect(cells[3].row.index).to eq 0
        expect(cells[4].row.index).to eq 1
        expect(cells[5].row.index).to eq 1
        expect(cells[6].row.index).to eq 1
        expect(cells[7].row.index).to eq 1
        expect(cells[8].row.index).to eq 2
        expect(cells[9].row.index).to eq 2
        expect(cells[10].row.index).to eq 2
        expect(cells[11].row.index).to eq 2
        expect(cells[12].row.index).to eq 3
        expect(cells[13].row.index).to eq 3
        expect(cells[14].row.index).to eq 3
        expect(cells[15].row.index).to eq 3

        expect(cells[0].col.index).to eq 0
        expect(cells[1].col.index).to eq 1
        expect(cells[2].col.index).to eq 2
        expect(cells[3].col.index).to eq 3
        expect(cells[4].col.index).to eq 0
        expect(cells[5].col.index).to eq 1
        expect(cells[6].col.index).to eq 2
        expect(cells[7].col.index).to eq 3
        expect(cells[8].col.index).to eq 0
        expect(cells[9].col.index).to eq 1
        expect(cells[10].col.index).to eq 2
        expect(cells[11].col.index).to eq 3
        expect(cells[12].col.index).to eq 0
        expect(cells[13].col.index).to eq 1
        expect(cells[14].col.index).to eq 2
        expect(cells[15].col.index).to eq 3

        expect(cells[0].block.index).to eq 0
        expect(cells[1].block.index).to eq 0
        expect(cells[2].block.index).to eq 1
        expect(cells[3].block.index).to eq 1
        expect(cells[4].block.index).to eq 0
        expect(cells[5].block.index).to eq 0
        expect(cells[6].block.index).to eq 1
        expect(cells[7].block.index).to eq 1
        expect(cells[8].block.index).to eq 2
        expect(cells[9].block.index).to eq 2
        expect(cells[10].block.index).to eq 3
        expect(cells[11].block.index).to eq 3
        expect(cells[12].block.index).to eq 2
        expect(cells[13].block.index).to eq 2
        expect(cells[14].block.index).to eq 3
        expect(cells[15].block.index).to eq 3
      end

      (grid_size**2).times do |cell_index|
        it "expect cell #{cell_index} to be a Sudoku::Cell" do
          expect(cells[cell_index]).to be_a(Sudoku::Cell)
        end

        it "expect cell #{cell_index} to have correct value" do
          expect(cells[cell_index].value).to eq puzzle_definition[cell_index].to_i
        end
      end
    end
  end
end
