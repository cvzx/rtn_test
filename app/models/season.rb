# frozen_string_literal: true

class Season < Product
  has_many :episodes, -> { order(number: :asc) }, dependent: :destroy
end
