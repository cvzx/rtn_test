# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movies and seasons list', type: :request do
  describe 'GET /products/movies_and_seasons' do
    let!(:movies)  { create_list(:movie, 5) }
    let!(:seasons) { create_list(:season_with_episodes, 5) }
    let(:products) { movies + seasons }

    let(:expected_products) do
      products.sort_by(&:created_at).as_json(only: %i[title plot created_at])
    end

    it 'returns list of movies' do
      get '/products/movies_and_seasons'

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema('movies_and_seasons/list')
      expect(response.body).to include_json(expected_products)
    end
  end
end
