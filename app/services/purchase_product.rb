# frozen_string_literal: true

class PurchaseProduct
  prepend SimpleCommand

  EXPIRATION_PERIOD = 2.days

  attr_reader :params

  def initialize(params)
    @params = params.to_h
  end

  def call
    validation = validate_params

    if validation.success?
      create_purchase
      set_expiration_time
    else
      collect_errors(validation)
    end
  end

  private

  attr_reader :purchase

  def validate_params
    self.class.validator.(params)
  end

  def create_purchase
    @purchase = Purchase.create(params)
  rescue StandardError => e
    errors.add(:creating, e.message)
  end

  def set_expiration_time
    return if failure?

    purchase.update(expires_at: Time.now + EXPIRATION_PERIOD)
  end

  def collect_errors(validation)
    errors.add_multiple_errors validation.errors.to_h
  end

  class << self
    attr_writer :validator

    def validator
      @validator ||= PurchaseValidator.new
    end
  end
end
