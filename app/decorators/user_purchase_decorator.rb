# frozen_string_literal: true

class UserPurchaseDecorator < Draper::Decorator
  delegate_all

  def as_json(*_args)
    { title: title, plot: plot, expires_at: expires_at }
  end

  private

  def title
    product.title
  end

  def plot
    product.plot
  end
end
