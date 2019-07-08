class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name, :address, :city, :state, :zip

  # def total_inventory  
  # end
  #
  # def ave_item_price
  # end
  #
  # def cities
  # end


end
