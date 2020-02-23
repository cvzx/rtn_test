# frozen_string_literal: true

class Purchase < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :product
  belongs_to :purchase_option

  scope :active, -> { where('expires_at > ?', Time.now) }
end
