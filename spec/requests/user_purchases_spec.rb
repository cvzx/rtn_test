# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User purchases list', type: :request do
  describe 'GET /users/:user_id/purchases' do
    let!(:season_with_episodes) { create_list(:season, 5) }
    let(:movies)                { create_list(:movie, 5) }
    let(:user)                  { create(:user) }
    let(:purchase_option)       { create(:purchase_option) }
    let(:user_id)               { user.id }

    let!(:active_purchases) do
      movies.first(3).map do |movie|
        create_purchase(movie)
      end
    end

    let!(:expired_purchases) do
      movies.last(2).map do |movie|
        create_purchase(movie)
      end
    end

    let(:expected_purchases) do
      active_purchases.sort_by(&:expires_at)
                      .as_json(only: %i[title plot expires_at])
    end

    it 'returns list of movies' do
      get "/users/#{user_id}/purchases"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema('user_purchases/list')
      expect(response.body).to include_json(expected_purchases)
    end
  end

  private

  def create_purchase(product)
    create(:purchase,
           user: user,
           product: product,
           purchase_option: purchase_option)
  end
end
