# frozen_string_literal: true

FactoryBot.define do
  factory :purchase do
    association :user
    association :product
    association :purchase_option
  end
end
