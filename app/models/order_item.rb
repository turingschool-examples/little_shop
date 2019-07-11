class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  validates_presence_of :quantity, :price

  def self.get_quantity(item)
    where(item: item).first.quantity
  end

  def self.get_price(item)
    where(item: item).first.price
  end
end
