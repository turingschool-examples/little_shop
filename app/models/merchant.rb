class Merchant < ApplicationRecord
  has_many :items

  def has_orders?
     if self.items.joins(:order_items).count == 0
       false
     else
       true
     end
  end
end
