#!/usr/bin/env ruby
# frozen_string_literal: true

require './printer'
require './validator'
require './guess_solver'
require './logic_solver'

def solve_with_guess(game)
  solved_game = solve(game)

  if Validator.new(solved_game).valid?
    Printer.print_game(solved_game)
  else
    puts "Game #{game} is invalid!"
  end
end

def solve_with_logic(game)
  LogicSolver.new(game).solve
end

games = ['examples/game_01.txt']

games.each do |game_name|
  game = File.read(game_name).strip

  solve_with_logic(game)
end
