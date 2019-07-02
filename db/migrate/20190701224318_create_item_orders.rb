class CreateItemOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :item_orders do |t|
      t.integer :quantity
      t.float :price
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
    end
  end
end
