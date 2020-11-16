# frozen_string_literal: true

class Puzzle < ApplicationRecord
  self.implicit_order_column = :created_at

  validates :definition, presence: true
end
