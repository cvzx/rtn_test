# frozen_string_literal: true

class SeasonDecorator < Draper::Decorator
  delegate_all

  attr_writer :episode_decorator

  def as_json(*_args)
    {
      title: title,
      plot: plot,
      number: number,
      created_at: created_at,
      episodes: decorated_episodes
    }
  end

  private

  def decorated_episodes
    episode_decorator.decorate_collection(object.episodes)
  end

  def episode_decorator
    @episode_decorator ||= EpisodeDecorator
  end
end
