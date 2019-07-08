class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def subtotal
    price_per_item * quantity
  end
end
