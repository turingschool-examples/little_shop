class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  attr_reader :items

end
