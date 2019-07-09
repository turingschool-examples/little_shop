class Item < ApplicationRecord
  belongs_to :merchant
  has_many :order_items
  has_many :reviews
  has_many :orders, through: :order_items

  def best_reviews
    reviews.order(rating: :desc).limit(3)
  end

  def worst_reviews
    reviews.order(:rating).limit(3)
  end

  def average_rating
    reviews.average(:rating).to_f.round(2)
  end
end
