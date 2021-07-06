class AddTimestampsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_timestamps :orders, null:true 
  end
end
