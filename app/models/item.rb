class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :order_items
  has_many :orders, through: :order_items


  def average_rating
    self.reviews.average(:rating)
  end

  def top_reviews
    self.reviews.order(rating: :desc).select(:title, :rating).limit(3)
  end

  def worst_reviews
    self.reviews.order(rating: :asc).select(:title, :rating).limit(3)
  end
end
