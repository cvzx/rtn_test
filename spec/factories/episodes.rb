# frozen_string_literal: true

FactoryBot.define do
  factory :episode, class: 'Episode' do
    season

    title { Faker::Food.dish }
    plot  { Faker::Food.description }
    type  { 'Episode' }

    number { rand(1..100) }
    # sequence(:number) { |n| n }
  end
end
