# frozen_string_literal: true

class Printer
  def self.print_game(game)
    abort 'Invalid game!' unless game.strip.size == 81

    print_header

    game.strip.chars.each_slice(9).each_with_index do |row, row_index|
      print_row_separator if (row_index % 3).zero?
      print "#{row_indices[row_index]} | "
      puts format_row(row)
    end
  end

  def self.format_row(row)
    row.map { |n| n.to_i.zero? ? ' ' : n }
       .insert(3, '|')
       .insert(7, '|')
       .join(' ')
  end

  def self.row_indices
    ('A'..'I').to_a
  end

  def self.print_header
    puts '  | 1 2 3 | 4 5 6 | 7 8 9 '
  end

  def self.print_row_separator
    puts '--+-------+-------+-------'
  end
end
