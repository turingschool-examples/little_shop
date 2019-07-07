class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name, :address, :city, :state, :zip

  def top_three_items
    items.joins(:reviews).order("reviews.rating desc").limit(3)
  end
end
