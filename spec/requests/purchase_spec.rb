# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Purchase product', type: :request do
  describe 'POST /products/purchase' do
    let!(:movies)          { create_list(:movie, 5) }
    let!(:user)            { create(:user) }
    let!(:purchase_option) { create(:purchase_option) }
    let(:product)          { movies.first }

    let!(:trade_offer) do
      create(:trade_offer,
             product_id: product.id,
             purchase_option_id: purchase_option.id)
    end

    context 'when params are valid' do
      let(:expected_expires_at) { Time.now + 2.days }
      let(:purchase)            { Purchase.first }

      let(:params) do
        {
          user_id: user.id,
          product_id: product.id,
          purchase_option_id: purchase_option.id
        }
      end

      it 'returns success' do
        post '/products/purchase', params: params

        expect(response).to have_http_status(200)
        # expect(response).to match_json_schema('purchase/success')
      end

      it 'creates new purchase' do
        expect do
          post '/products/purchase', params: params
        end.to change(Purchase, :count).from(0).to(1)

        expect(purchase.expires_at)
          .to be_within(1.second)
          .of expected_expires_at
      end
    end

    context 'when params are invalid' do
      context 'when user_id is nil' do
        let(:params) do
          {
            user_id: nil,
            product_id: product.id,
            purchase_option_id: purchase_option.id
          }
        end

        it 'does not create new purchase' do
          expect do
            post '/products/purchase', params: params
          end.not_to change(Purchase, :count)
        end

        it 'retuns error messages' do
          post '/products/purchase', params: params

          expect(response).to have_http_status(200)
          expect(json_body['errors']['user_id']).not_to be_empty
        end
      end

      context 'when product_id is nil' do
        let(:params) do
          {
            user_id: user.id,
            product_id: nil,
            purchase_option_id: purchase_option.id
          }
        end

        it 'does not create new purchase' do
          expect do
            post '/products/purchase', params: params
          end.not_to change(Purchase, :count)
        end

        it 'retuns error messages' do
          post '/products/purchase', params: params

          expect(response).to have_http_status(200)
          expect(json_body['errors']['product_id']).not_to be_empty
        end
      end

      context 'when purchase_option_id is nil' do
        let(:params) do
          {
            user_id: user.id,
            product_id: product.id,
            purchase_option_id: nil
          }
        end

        it 'does not create new purchase' do
          expect do
            post '/products/purchase', params: params
          end.not_to change(Purchase, :count)
        end

        it 'retuns error messages' do
          post '/products/purchase', params: params

          expect(response).to have_http_status(200)
          expect(json_body['errors']['purchase_option_id']).not_to be_empty
        end
      end

      context 'when user already bought the product' do
        let!(:purchase) do
          create(:purchase,
                 user_id: user.id,
                 product_id: product.id,
                 purchase_option_id: purchase_option.id,
                 expires_at: Time.new + 2.days)
        end

        let(:params) do
          {
            user_id: user.id,
            product_id: product.id,
            purchase_option_id: purchase_option.id
          }
        end

        context 'when product is active' do
          it 'does not create new purchase' do
            expect do
              post '/products/purchase', params: params
            end.not_to change(Purchase, :count)
          end

          it 'retuns error messages' do
            post '/products/purchase', params: params

            expect(response).to have_http_status(200)
            expect(json_body['errors']).not_to be_empty
          end
        end

        context 'when product is expired' do
          let(:expected_expires_at) { Time.now + 2.days }
          let(:new_purchase)        { Purchase.last }

          let!(:purchase) do
            create(:purchase,
                   user_id: user.id,
                   product_id: product.id,
                   purchase_option_id: purchase_option.id,
                   expires_at: Time.new - 2.days)
          end

          it 'creates new purchase' do
            expect do
              post '/products/purchase', params: params
            end.to change(Purchase, :count).by(1)

            expect(response).to have_http_status(200)
            expect(new_purchase.expires_at)
              .to be_within(1.second).of expected_expires_at
          end
        end
      end

      context 'when purchase option is not available for the product' do
        let(:params) do
          {
            user_id: user.id,
            product_id: product.id,
            purchase_option_id: purchase_option.id
          }
        end

        before { trade_offer.update_columns(product_id: movies.last.id) }

        it 'does not create new purchase' do
          expect do
            post '/products/purchase', params: params
          end.not_to change(Purchase, :count)
        end

        it 'retuns error messages' do
          post '/products/purchase', params: params

          expect(response).to have_http_status(200)
          expect(json_body['errors']).not_to be_empty
        end
      end
    end
  end

  private

  def json_body
    JSON.parse(response.body)
  end
end
