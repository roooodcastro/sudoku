# frozen_string_literal: true

class Puzzle < ApplicationRecord
  validates :definition, presence: true
end
