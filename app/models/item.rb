class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :order_items
  has_many :orders, through: :order_items
  validates_presence_of :name, :description, :price, :inventory


  def average_rating
    self.reviews.average(:rating)
  end

  def top_reviews
    self.reviews.order(rating: :desc).limit(3)
  end

  def worst_reviews
    self.reviews.order(rating: :asc).limit(3)
  end

  def item_ordered?
    self.orders.count != 0
  end
end
