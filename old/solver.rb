# frozen_string_literal: true

require './grid'

class Solver
  attr_reader :initial_game, :current_game, :grid

  def initialize(game)
    @grid = Grid.new(game)
  end

  def solve; end

  def update_game(game)
    @current_game = game
    @validator = nil
  end

  def numbers
    current_game.chars.map(&:to_i)
  end

  def validator
    @validator ||= Validator.new(current_game)
  end
end
