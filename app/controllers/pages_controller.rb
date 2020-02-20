class PagesController < ApplicationController
  def home
    render json: {status: :error}
  end
end
