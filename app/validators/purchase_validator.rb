# frozen_string_literal: true

class PurchaseValidator < Dry::Validation::Contract
  params do
    required(:user_id).value(:integer)
    required(:product_id).value(:integer)
    required(:purchase_option_id).value(:integer)
  end

  rule(:product_id) do
    unless product_available_for_purchase?(value)
      key(:base).failure I18n.t('errors.not_available')
    end
  end

  rule(:product_id, :purchase_option_id) do
    unless trade_offer_exists?(values[:product_id], values[:purchase_option_id])
      key(:base).failure I18n.t('errors.no_purchase_option')
    end
  end

  rule(:user_id, :product_id) do
    if user_has_product?(values[:user_id], values[:product_id])
      key(:base).failure I18n.t('errors.already_purchased')
    end
  end

  private

  def product_available_for_purchase?(product_id)
    product = Product.find(product_id)

    Product::AVAILABLE_FOR_SALE.include?(product.type)
  end

  def trade_offer_exists?(product_id, purchase_option_id)
    TradeOffer.where(
      product_id: product_id,
      purchase_option_id: purchase_option_id
    ).exists?
  end

  def user_has_product?(user_id, product_id)
    Purchase.where(user_id: user_id, product_id: product_id).active.exists?
  end
end
