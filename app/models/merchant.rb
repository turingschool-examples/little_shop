class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def merchant_orders
    orders = Order.all
    orders.flat_map do |order|
      order.items.map do |item|
        item.merchant_id.to_s
      end
    end
  end
end
