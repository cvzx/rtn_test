class AddIndexByTypeToProducts < ActiveRecord::Migration[6.0]
  def change
    add_index(:products, :type)
  end
end
