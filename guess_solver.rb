#!/usr/bin/env ruby

require './validator.rb'
require './printer.rb'

@guesses = (1..9).to_a

def solve(game)
  solutions = @guesses.map do |guess|
    guessed_game = game.sub('0', guess.to_s)
    validator = Validator.new(guessed_game)

    return guessed_game if validator.complete?

    next unless validator.valid?

    solution = solve(guessed_game)
    return solution if solution

    solution
  end

  solutions.compact.first
end
