# frozen_string_literal: true

class FetchSeasons
  prepend SimpleCommand

  def initialize; end

  def call
    fetch_seasons_from_db
  end

  private

  def fetch_seasons_from_db
    Season.includes(:episodes).order(created_at: :asc)
  end
end
