class Order < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zipcode

  has_many :order_items
  has_many :items, through: :order_items
end
