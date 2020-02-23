# frozen_string_literal: true

class UsersController < ApplicationController
  def purchases
    fetching = FetchUserPurchases.(user_purchses_list_params)

    if fetching.success?
      purchases = UserPurchaseDecorator.decorate_collection(fetching.result)

      render json: purchases, status: :ok
    else
      render json: fetching.errors, status: :ok
    end
  end

  def user_purchses_list_params
    params.permit(:user_id)
  end
end
