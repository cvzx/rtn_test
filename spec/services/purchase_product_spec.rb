# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PurchaseProduct do
  describe '.call' do
    subject { described_class.(params) }

    let(:validator)      { double(:validator, call: nil) }
    let(:purchase_class) { double(create: nil) }

    let(:params) do
      { test: :test }
    end

    before do
      stub_const('Purchase', purchase_class)
      described_class.validator = validator

      allow(validator).to receive(:call)
        .with(params).and_return(validation_result)
    end

    context 'when params are valid' do
      let(:validation_result)   { double(success?: true) }
      let!(:purchase)           { double(update: nil) }
      let(:expected_expires_at) { be_within(1.second).of(Time.now + 2.days) }

      context 'wheh purchase creation was successful' do
        before do
          allow(purchase_class).to receive(:create)
            .with(params).and_return(purchase)
        end

        it 'succeeds' do
          is_expected.to be_success
        end

        it 'creates new purchase' do
          subject

          expect(purchase_class).to have_received(:create).with(params)
        end

        it 'sets expiration date' do
          subject

          expect(purchase).to have_received(:update)
            .with(expires_at: expected_expires_at)
        end
      end

      context 'wheh purchase creation was failed' do
        let(:error)           { StandardError.new('test') }
        let(:expected_errors) { { creating: [error.message] } }

        before do
          allow(purchase_class).to receive(:create)
            .with(params).and_raise(error)
        end

        it 'fails' do
          is_expected.to be_failure
        end

        it 'returns correct errors' do
          expect(subject.errors).to eq(expected_errors)
        end
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
