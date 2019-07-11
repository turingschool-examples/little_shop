class Merchant < ApplicationRecord

  has_many :items, dependent: :destroy
  validates :name,
            :address,
            :city,
            :state, presence: { message: "cannot be missing"}
  validates :zip, numericality: { message: "must be valid."}

  def merchant_orders
    items.joins(:orders).pluck(:merchant_id)
  end

  def average_price
    items.average(:price)
  end

  def cities
    items.joins(:orders).pluck('orders.city')
  end
end
