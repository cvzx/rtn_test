# frozen_string_literal: true

FactoryBot.define do
  factory :purchase do
    association :user
    association :product
    association :purchase_option
    expires_at { Time.now + 2.days }

    trait :expired do
      expires_at { Time.now - 2.days }
    end
  end
end
