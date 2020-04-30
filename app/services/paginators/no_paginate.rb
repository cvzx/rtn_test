# frozen_string_literal: true

class Paginators::NoPaginate
  prepend SimpleCommand

  attr_reader :collection

  def initialize(collection, *_args)
    @collection = collection
  end

  def call
    collection
  end
end
