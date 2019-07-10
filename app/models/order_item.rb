class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates_presence_of :count, :amount
end
