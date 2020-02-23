# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchUserPurchases do
  describe '.call' do
    subject { described_class.(params) }

    let(:validator)       { double(:validator, call: nil) }
    let(:movies)          { create_list(:movie, 10) }
    let(:user)            { create(:user) }
    let(:purchase_option) { create(:purchase_option) }

    let!(:active_purchases) do
      movies.first(5).map do |movie|
        create(:purchase, user: user, product: movie, purchase_option: purchase_option)
      end
    end

    let!(:expired_purchases) do
      movies.last(5).map do |movie|
        create(:purchase, :expired, user: user, product: movie, purchase_option: purchase_option)
      end
    end

    let(:params) do
      { user_id: user.id }
    end

    before do
      described_class.validator = validator
      allow(validator).to receive(:call)
        .with(params).and_return(validation_result)
    end

    context 'when params are valid' do
      let(:validation_result)  { double(success?: true) }
      let(:expected_purchases) { active_purchases.sort_by(&:expires_at) }

      it 'succeeds' do
        is_expected.to be_success
      end

      it 'returns correct list of user purchases' do
        expect(subject.result).to eq(expected_purchases)
      end
    end

    context 'when params are invalid' do
      let(:expected_errors) do
        double(to_h: { error1: ['text1'], error2: ['text2'] })
      end

      let(:validation_result) do
        double(success?: false, errors: expected_errors)
      end

      it 'fails' do
        is_expected.to be_failure
      end

      it 'returns correct validation errors' do
        expect(subject.errors).to eq(expected_errors.to_h)
      end
    end
  end
end
