#!/usr/bin/env ruby
# frozen_string_literal: true

require './solver'
require './validator'
require './printer'

class LogicSolver < Solver
  def solve
    # puts grid.cells.map(&:number).map(&:to_s).join

    # prospects = grid.empty_cells.map do |cell|
    #   [cell, valid_numbers_for_cell(cell)]
    # end.to_h

    # prospect = prospects.find { |_, p| p.size == 1 }

    # return unless prospect

    # prospect[0].solve(prospect[1].first)
    # solve
  end

  private

  def valid_numbers_for_cell(cell)
    # column   = grid.column(cell).select(&:solved?)
    # row      = grid.row(cell).select(&:solved?)
    # sub_grid = grid.sub_grid(cell).select(&:solved?)

    # col_prospects  = (1..9).to_a - column.map(&:number)
    # row_prospects  = (1..9).to_a - row.map(&:number)
    # grid_prospects = (1..9).to_a - sub_grid.map(&:number)

    # col_prospects & row_prospects & grid_prospects
  end
end
