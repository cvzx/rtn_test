# frozen_string_literal: true

class FetchMovies
  prepend SimpleCommand
  include Cacheable

  def initialize; end

  def call
    with_caching do
      fetch_movies_from_db
    end
  end

  private

  def fetch_movies_from_db
    Movie.order(created_at: :asc)
  end
end
