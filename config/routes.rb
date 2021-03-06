# frozen_string_literal: true

Rails.application.routes.draw do
  scope :products do
    get '/movies', to: 'products#movies'
    get '/seasons', to: 'products#seasons'
    get '/movies_and_seasons', to: 'products#movies_and_seasons'

    post '/:product_id/purchase', to: 'products#purchase'
  end

  scope :users do
    get '/:user_id/purchases', to: 'users#purchases'
  end
end
