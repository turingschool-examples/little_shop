class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def grand_total
    gt = order_items.pluck("sum(quantity * price)")
    gt.sum
  end
end
