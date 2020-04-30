# frozen_string_literal: true

class FetchMoviesValidator < Dry::Validation::Contract
  params do
    optional(:page).value(:integer)
    optional(:per_page).value(:integer)
  end

  rule(:page) do
    key.failure('should be greater than 1') if key? && value < 1
  end

  rule(:per_page) do
    key.failure('should be greater than 1') if key? && value < 1
  end
end
