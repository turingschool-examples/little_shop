class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def self.get_quantity(item)
    where(item_id: item.id).first.quantity
  end
end
