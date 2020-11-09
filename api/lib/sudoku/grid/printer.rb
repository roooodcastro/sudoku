# frozen_string_literal: true

module Sudoku
  class Grid
    module Printer
      VERTICAL_SEPARATOR   = '|'
      HORIZONTAL_SEPARATOR = '-'
      CROSS_SEPARATOR      = '+'

      # Returns a formatted Sudoku grid, with blocks separated both vertically and horiontally with separators. Every
      # sub_grid_size rows (3 rows for classic Sudoku), a separator row is printed to separate the blocks.
      # The "join(print_separator_row)" method is used to avoid a trailing separator row at the end.
      def print
        rows.values.in_groups_of(sub_grid_size).map do |row_group|
          row_group.map(&method(:print_row)).join
        end.join(print_separator_row)
      end

      private

      # Returns a formatted row, with blocks separated by VERTICAL_SEPARATORS, and with a newline character at the end.
      # In classic Sudoku, a block is three cells wide and tall, so between each three cells there's a separator.
      # The "join(' ')" method is used to avoid a trailing separator at the end.
      def print_row(row)
        printed_row = row.cells.in_groups_of(sub_grid_size).map do |cell_group|
          cell_group.map { |cell| cell.value || '.' }.join(' ')
        end
        "#{printed_row.join(VERTICAL_SEPARATOR)}\n"
      end

      # Returns a separator row to visually identify different blocks in the puzzle. For a classic Sudoku puzzle, there
      # will be three blocks in each direction, so the separator row must have two "cross" separators, indicating where
      # separator rows and columns meet.
      # sub_grid_size_with_spaces is defined as twice the size of the sub grid, to accommodate the spaces between the
      # numbers. The -1 at the end indicate that there's no space between the last number and the right separator.
      def print_separator_row
        sub_grid_size_with_spaces = (sub_grid_size * 2) - 1
        row = Array.new(sub_grid_size).map { HORIZONTAL_SEPARATOR * sub_grid_size_with_spaces }.join(CROSS_SEPARATOR)
        "#{row}\n"
      end
    end
  end
end
