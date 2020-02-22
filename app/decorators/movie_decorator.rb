# frozen_string_literal: true

class MovieDecorator < Draper::Decorator
  delegate_all

  def as_json(*_args)
    { title: title, plot: plot, created_at: created_at }
  end
end
