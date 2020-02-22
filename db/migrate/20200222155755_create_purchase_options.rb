class CreatePurchaseOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_options do |t|
      t.money :price, null: false
      t.integer :video_quality, null: false, default: 0

      t.timestamps
    end
  end
end
