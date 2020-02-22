# frozen_string_literal: true

FactoryBot.define do
  factory :movie, class: 'Product' do
    title { Faker::Food.dish }
    plot  { Faker::Food.description }
    type  { 'Movie' }
  end
end
