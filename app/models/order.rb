class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  validates_presence_of :name, :address, :city, :state, :zip

  def add_items(items)
    items.each do |item,qty|
      OrderItem.create(order: self, item: item, quantity: qty, price: item.price)
    end
  end
end
