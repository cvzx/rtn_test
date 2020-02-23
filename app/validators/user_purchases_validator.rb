# frozen_string_literal: true

class UserPurchasesValidator < Dry::Validation::Contract
  params do
    required(:user_id).value(:integer)
  end
end
