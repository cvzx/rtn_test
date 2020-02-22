# frozen_string_literal: true

class Season < Product
  has_many :episodes, -> { order(number: :asc) }, dependent: :destroy
  has_many :purchase_options, through: :trade_offers
  has_many :purchases, dependent: :nullify
end
