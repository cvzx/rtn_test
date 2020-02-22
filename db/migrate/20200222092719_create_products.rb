# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :plot, null: false
      t.string :type

      t.timestamps
    end
  end
end
