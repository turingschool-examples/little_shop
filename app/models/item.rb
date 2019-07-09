class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :orders, through: :order_items
end
