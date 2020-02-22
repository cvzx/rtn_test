# frozen_string_literal: true

class EpisodeDecorator < Draper::Decorator
  delegate_all

  def as_json(*_args)
    {
      number: number,
      title: title,
      plot: plot,
      created_at: created_at
    }
  end
end
