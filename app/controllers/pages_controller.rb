# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    render json: { status: :error }
  end
end
