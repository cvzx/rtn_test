# frozen_string_literal: true

FactoryBot.define do
  factory :trade_offer do
    association :product
    association :purchase_option
  end
end
