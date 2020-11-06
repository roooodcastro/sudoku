# frozen_string_literal: true

class PuzzlesController < ApplicationController
  include RecordNotFoundRescuable

  before_action :set_puzzle, only: %i[show update]

  def index
    puzzles = Puzzle.all

    render json: { puzzles: puzzles.as_json }, status: :ok
  end

  def show
    render json: { puzzle: @puzzle.as_json }, status: :ok
  end

  def create
    puzzle = Puzzle.create(puzzle_params)

    json_response(puzzle, success: puzzle.persisted?)
  end

  def update
    updated = @puzzle.update(puzzle_params)

    json_response(@puzzle, success: updated)
  end

  private

  def set_puzzle
    @puzzle = Puzzle.find(params[:id])
  end

  def puzzle_params
    params.require(:puzzle).permit(%i[name author definition slug])
  end

  def json_response(puzzle, success: true)
    if success
      render json: { puzzle: puzzle.as_json }, status: :ok
    else
      render json: { puzzle: puzzle.as_json, errors: puzzle.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
