# frozen_string_literal: true

class TradeOffer < ApplicationRecord
  belongs_to :product
  belongs_to :purchase_option
end
