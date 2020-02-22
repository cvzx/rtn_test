# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EpisodeDecorator do
  let(:episode) { create(:episode) }

  subject { EpisodeDecorator.new(episode) }

  describe '#as_json' do
    let(:expected_hash) do
      {
        number: episode.number,
        title: episode.title,
        plot: episode.plot,
        created_at: episode.created_at
      }
    end

    it 'returns the episode as correct hash' do
      expect(subject.as_json).to eq(expected_hash)
    end
  end
end
