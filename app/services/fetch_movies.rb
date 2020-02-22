# frozen_string_literal: true

class FetchMovies
  prepend SimpleCommand

  def initialize; end

  def call
    fetch_movies_from_db
  end

  private

  def fetch_movies_from_db
    Movie.order(created_at: :asc)
  end
end
