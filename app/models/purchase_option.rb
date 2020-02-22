# frozen_string_literal: true

class PurchaseOption < ApplicationRecord
  has_many :products, through: :trade_offers

  enum video_quality: { sd: 0, hd: 1 }
end
