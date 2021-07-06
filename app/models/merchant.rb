class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name, :address, :city, :state, :zip


  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def has_orders?
    self.items.joins(:order_items).count != 0
  end

  def total_merchant_items
    self.items.count
  end

  def merchant_average_price
    self.items.average(:price)
  end

  def distinct_cities
    city = self.items.joins(:orders).distinct("orders.city").pluck("orders.city")
    city.sum
  end
end
