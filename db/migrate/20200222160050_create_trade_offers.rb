class CreateTradeOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :trade_offers do |t|
      t.references :product, foreign_key: true
      t.references :purchase_option, foreign_key: true

      t.timestamps
    end
  end
end
