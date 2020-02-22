# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchSeasons do
  let(:expected_result) do
    Season.includes(:episodes).order(created_at: :asc)
  end

  before do
    create_list(:season_with_episodes, 5)
  end

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
