class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  validates_presence_of :name, :address, :city, :state, :zip

  def add_items(items)
    items.each do |item,qty|
      self.items << item
      order_item = OrderItem.where(item_id: item.id).first
      order_item.quantity = qty
      order_item.price = item.price
      order_item.save
    end
  end
end
