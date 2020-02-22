# frozen_string_literal: true

class AddNumberAndSeasonIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :number, :integer
    add_reference :products, :season, foreign_key: { to_table: :products, on_delete: :cascade }
  end
end
