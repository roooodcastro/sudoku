# frozen_string_literal: true

module Sudoku
  class Grid
    include Sudoku::Grid::Printer

    attr_reader :cells, :rows, :cols, :blocks, :units, :grid_size, :sub_grid_size, :numbers

    def initialize(grid_string)
      grid_values = grid_string.split('')
      @grid_size = Math.sqrt(grid_values.size).to_i
      @sub_grid_size = Math.sqrt(grid_size).to_i
      @numbers = grid_size.times.map { |n| n + 1 }

      build_grid(grid_values)
    end

    def solved_cells_count
      cells.count(&:solved?)
    end

    def solved?
      solved_cells_count == cells.size
    end

    def current_definition
      cells.map { |cell| cell.value.to_i }.join
    end

    private

    def build_grid(grid_values)
      @rows   = build_units
      @cols   = build_units
      @blocks = build_units
      @units  = rows.values + cols.values + blocks.values
      @cells  = build_cells(grid_values)
      cells.each(&:find_peers)
    end

    def build_units
      grid_size.times.each_with_object({}) { |index, result| result[index] = Sudoku::Unit.new(index) }
    end

    def build_cells(values)
      values.each_with_index.map do |value, index|
        row_index   = index / grid_size
        col_index   = index % grid_size
        block_index = block_index(index)

        cell = build_cell(value, row_index, col_index, block_index)

        assign_cell_to_units(cell, row_index, col_index, block_index)

        cell
      end
    end

    def build_cell(value, row_index, col_index, block_index)
      Cell.new(
        value: value,
        row:   rows[row_index],
        col:   cols[col_index],
        block: blocks[block_index],
        grid:  self
      )
    end

    def block_index(grid_index)
      block_col_index = (grid_index / sub_grid_size) % sub_grid_size
      block_row_index = grid_index / (grid_size * sub_grid_size)
      block_row_index * sub_grid_size + block_col_index
    end

    def assign_cell_to_units(cell, row_index, col_index, block_index)
      rows[row_index].cells << cell
      cols[col_index].cells << cell
      blocks[block_index].cells << cell
    end
  end
end
