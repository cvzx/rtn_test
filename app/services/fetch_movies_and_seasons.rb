# frozen_string_literal: true

class FetchMoviesAndSeasons
  prepend SimpleCommand

  TYPES = %w[Movie Season].freeze

  def initialize; end

  def call
    fetch_movies_and_seasons_from_db
  end

  private

  def fetch_movies_and_seasons_from_db
    Product.where(type: TYPES).order(created_at: :asc)
  end
end
