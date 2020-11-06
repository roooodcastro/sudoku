# frozen_string_literal: true

FactoryBot.define do
  factory :puzzle do
    definition { Array.new(81).map { (1..9).to_a.sample }.join }
  end
end
