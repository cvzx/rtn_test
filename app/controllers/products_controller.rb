# frozen_string_literal: true

class ProductsController < ApplicationController
  def movies
    fetching = FetchMovies.()
    movies   = MovieDecorator.decorate_collection(fetching.result)

    render json: movies, status: :ok
  end

  def seasons
    fetching = FetchSeasons.()
    seasons  = SeasonDecorator.decorate_collection(fetching.result)

    render json: seasons, status: :ok
  end

  def movies_and_seasons
    fetching = FetchMoviesAndSeasons.()
    products = MovieDecorator.decorate_collection(fetching.result)

    render json: products, status: :ok
  end
end
