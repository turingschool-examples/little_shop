class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def subtotal
    self.quantity * self.price
  end
end
