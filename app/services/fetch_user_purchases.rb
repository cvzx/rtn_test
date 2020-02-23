# frozen_string_literal: true

class FetchUserPurchases
  prepend SimpleCommand

  attr_reader :params

  def initialize(params)
    @params = params.to_h
  end

  def call
    validation = validate_params

    if validation.success?
      fetch_user_purchases_from_db
    else
      collect_errors(validation)
    end
  end

  private

  def validate_params
    self.class.validator.(params)
  end

  def fetch_user_purchases_from_db
    Purchase.where(user_id: user_id).active.order(expires_at: :asc)
  end

  def collect_errors(validation)
    errors.add_multiple_errors validation.errors.to_h
  end

  def user_id
    @user_id ||= params[:user_id]
  end

  class << self
    attr_writer :validator

    def validator
      @validator ||= UserPurchasesValidator.new
    end
  end
end
