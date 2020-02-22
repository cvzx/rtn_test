# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchMovies do
  let(:expected_result) { Movie.order(created_at: :asc) }

  before { create_list(:movie, 5) }

  describe '.call' do
    subject { described_class.() }

    it 'succeeds' do
      is_expected.to be_success
    end

    it 'returns movies with creation_at asc order' do
      expect(subject.result).to eq expected_result
    end
  end
end
