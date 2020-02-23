# frozen_string_literal: true

module Cacheable
  def with_caching(expiration_time: 12.hours, cach_column: :updated_at)
    cache_key = yield.cache_key(cach_column)

    Rails.cache.fetch(cache_key, expires_in: expiration_time) do
      yield
    end
  end
end
