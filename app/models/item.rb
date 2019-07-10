class Item < ApplicationRecord
  belongs_to :merchant
  has_many :order_items
  has_many :reviews, dependent: :destroy
  has_many :orders, through: :order_items

  validates :name,
            :description,
            :image, presence: { message: "cannot be missing"}
  validates :price, :inventory, numericality: { message: "must be a valid number"}

  def best_reviews
    reviews.order(rating: :desc).limit(3)
  end

  def worst_reviews
    reviews.order(:rating).limit(3)
  end

  def average_rating
    reviews.average(:rating)
  end

  def item_orders
    Order.joins(:order_items).pluck(:item_id)
  end
end
