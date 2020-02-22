# frozen_string_literal: true

class Movie < Product
  has_many :purchases, dependent: :nullify
end
