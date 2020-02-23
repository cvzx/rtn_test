# frozen_string_literal: true

class FetchSeasons
  prepend SimpleCommand
  include Cacheable

  def initialize; end

  def call
    with_caching do
      fetch_seasons_from_db
    end
  end

  private

  def fetch_seasons_from_db
    Season.includes(:episodes).order(created_at: :asc)
  end
end
