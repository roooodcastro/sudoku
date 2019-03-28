#!/usr/bin/env ruby

require './printer.rb'
require './validator.rb'
require './guess_solver.rb'

games = ['examples/game_01.txt']

games.each do |game_name|
  game = File.read(game_name).strip
  solved_game = solve(game)

  if Validator.new(solved_game).valid?
    Printer.print_game(solved_game)
  else
    puts "Game #{game} is invalid!"
  end
end
