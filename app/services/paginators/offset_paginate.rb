# frozen_string_literal: true

class Paginators::OffsetPaginate
  prepend SimpleCommand

  DEFAULT_PAGE     = 1
  DEFAULT_PER_PAGE = 5

  attr_reader :collection, :params

  def initialize(collection, params)
    @collection = collection
    @params     = params
  end

  def call
    paginate_collection
  end

  private

  def paginate_collection
    collection.offset(offset).limit(per_page)
  end

  def offset
    @offset ||= (page.to_i - 1) * per_page.to_i
  end

  def page
    @page ||= (params[:page] || DEFAULT_PAGE)
  end

  def per_page
    @per_page ||= (params[:per_page] || DEFAULT_PER_PAGE)
  end
end
