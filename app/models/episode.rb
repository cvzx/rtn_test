# frozen_string_literal: true

class Episode < Product
  belongs_to :season, class_name: 'Product'
end
