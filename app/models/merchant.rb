class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name, :address, :city, :state, :zip

  def has_items_in_orders?
    items.joins(:orders).exists?
  end

  def top_three_items
    items.joins(:reviews).order("reviews.rating desc").limit(3)
  end

  def cities_served
    items.joins(:orders).order("orders.city").distinct.pluck("orders.city")
  end
end
