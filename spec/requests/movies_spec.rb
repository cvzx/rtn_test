# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movies list', type: :request do
  describe 'GET /products/movies' do
    let!(:movies) { create_list(:movie, 5) }

    let(:expected_movies) do
      movies.sort_by(&:created_at).as_json(only: %i[title plot created_at])
    end

    it 'returns list of movies' do
      get '/products/movies'

      expect(response).to have_http_status(200)
      # expect(response).to match_json_schema('movies/list')
      expect(response.body).to include_json(expected_movies)
    end
  end
end
