class AddTimestampsToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_timestamps :order_items, null:true
  end
end
