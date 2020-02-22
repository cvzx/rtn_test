# frozen_string_literal: true

FactoryBot.define do
  factory :season, class: 'Season' do
    title { Faker::Food.dish }
    plot  { Faker::Food.description }
    type  { 'Season' }

    number { rand(1..100) }
    # sequence(:number) { |n| n }

    factory :season_with_episodes do
      transient do
        episodes_count { 5 }
      end

      after :create do |season, evaluator|
        create_list(:episode, evaluator.episodes_count, season_id: season.id)
      end
    end
  end
end
