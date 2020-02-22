# frozen_string_literal: true

class ProductsController < ApplicationController
  def movies
    fetching = FetchMovies.()
    movies = MovieDecorator.decorate_collection(fetching.result)

    render json: movies, status: :ok
  end
end
