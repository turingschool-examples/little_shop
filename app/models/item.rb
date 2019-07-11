class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :order_items
  has_many :orders, through: :order_items
  validates_presence_of :name, :description, :price, :image, :inventory

  def average_rating
    reviews.average(:rating)
  end

  def sorted_reviews
    reviews.order(:rating)
  end
end
