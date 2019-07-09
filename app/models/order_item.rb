class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def subtotal
    self.price * self.quantity.to_i
  end

  def total
    order_items.sum(:price)
  end
end
