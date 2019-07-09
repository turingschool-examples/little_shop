class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items

  def grand_total(items)
    total = 0
    items.each do |item|
      total += item.subtotal
    end
    total
  end
end
