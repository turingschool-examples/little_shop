class Order < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zipcode

  has_many :order_items
  has_many :items, through: :order_items

  def desired_quantity(item_id, order_id)
    order_items.where(item_id: item_id, order_id: order_id).sum(:quantity)
  end

  def subtotal(item_id, order_id)
    price = order_items.where(item_id: item_id, order_id: order_id).sum(:price)
    quantity = desired_quantity(item_id, order_id)
    price * quantity
  end

  def grand_total
    order_items.sum do |order_item|
      subtotal(order_item.item_id, order_item.order_id)
    end
  end
end
