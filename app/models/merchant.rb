class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name, :address, :city, :state, :zip


  def has_orders?
     if self.items.joins(:order_items).count == 0
       false
     else
       true
     end
  end
end
