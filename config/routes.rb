# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/purchases'
  get 'products/movies'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :products do
    get '/movies', to: 'products#movies'
    get '/seasons', to: 'products#seasons'
    get '/movies_and_seasons', to: 'products#movies_and_seasons'

    post '/purchase', to: 'products#purchase'
  end

  scope :users do
    get '/:user_id/purchases', to: 'users#purchases'
  end
end
