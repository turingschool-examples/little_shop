class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name, :address, :city, :state, :zip

  def total_inventory
    self.items.count
    binding.pry
  end


end
