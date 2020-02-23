# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPurchaseDecorator do
  let(:purchase) { create(:purchase, product: create(:movie)) }

  subject { described_class.new(purchase) }

  describe '#as_json' do
    let(:expected_hash) do
      {
        title: purchase.product.title,
        plot: purchase.product.plot,
        expires_at: purchase.expires_at
      }
    end

    it 'returns the movie as correct hash' do
      expect(subject.as_json).to eq(expected_hash)
    end
  end
end
