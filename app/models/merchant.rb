class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name, :address, :city, :state, :zip

  def total_inventory
    self.items.count
    binding.pry
  end

  def ave_item_price
    # .average isnt working for this for some reason when i was prying into it.
    total = self.items.sum do |item|
              item.price
            end
    total / total_inventory
  end

  def cities
    self.items.joins(:orders).distinct("orders.city").order("orders.city").pluck("orders.city")
  end
  
  def has_items_in_orders
    self.items.joins(:order_items).exists?
  end

end
