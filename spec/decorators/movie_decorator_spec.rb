# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MovieDecorator do
  let(:movie) { create(:movie) }

  subject { described_class.new(movie) }

  describe '#as_json' do
    let(:expected_hash) do
      {
        title: movie.title,
        plot: movie.plot,
        created_at: movie.created_at
      }
    end

    it 'returns the movie as correct hash' do
      expect(subject.as_json).to eq(expected_hash)
    end
  end
end
