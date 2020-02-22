# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SeasonDecorator do
  subject { SeasonDecorator.new(season) }

  let(:season) { create(:season_with_episodes) }

  let(:decorated_episodes) do
    [
      { episode1: 'test' },
      { episode2: 'test' }
    ]
  end

  let(:episode_decorator) do
    double(:episode_decorator,
           decorate_collection: decorated_episodes)
  end

  before do
    subject.episode_decorator = episode_decorator
  end

  describe '#as_json' do
    let(:expected_hash) do
      {
        title: season.title,
        plot: season.plot,
        number: season.number,
        created_at: season.created_at,
        episodes: decorated_episodes
      }
    end

    it 'returns the movie as correct hash' do
      expect(subject.as_json).to eq(expected_hash)
    end
  end
end
