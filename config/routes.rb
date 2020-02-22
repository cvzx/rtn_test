# frozen_string_literal: true

Rails.application.routes.draw do
  get 'products/movies'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :products do
    get '/movies', to: 'products#movies'
    get '/seasons', to: 'products#seasons'
  end
end
