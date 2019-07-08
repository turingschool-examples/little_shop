class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def subtotal
    price_per_item * quantity
  end

  def self.grandtotal(order_id) #move to order as instance method
    where(order_id: order_id).sum("price_per_item * quantity")
  end
end
