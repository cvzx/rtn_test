# frozen_string_literal: true

FactoryBot.define do
  factory :purchase_option do
    price         { 1234.567 }
    video_quality { 1 }
  end
end
