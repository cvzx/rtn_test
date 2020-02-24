# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Seasons list', type: :request do
  describe 'GET /products/seasons' do
    let!(:seasons) do
      create_list(:season_with_episodes, 5)
    end

    let(:expected_seasons) do
      seasons = Season.includes(:episodes).order(created_at: :asc)
      seasons.as_json(
        only: %i[title plot number created_at],
        include: {
          episodes: {
            only: %i[title plot number]
          }
        }
      )
    end

    it 'returns list of seasons' do
      get '/products/seasons'

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema('seasons/list')
      expect(response.body).to include_json(expected_seasons)
    end
  end
end
