# frozen_string_literal: true

Rails.application.routes.draw do
  resources :puzzles, only: %i[index show create update]
end
