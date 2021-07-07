class AddPricePerItemToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :price_per_item, :float
  end
end
