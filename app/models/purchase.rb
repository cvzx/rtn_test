# frozen_string_literal: true

class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :purchase_option

  scope :active, -> { where('expires_at > ?', Time.now) }
end
