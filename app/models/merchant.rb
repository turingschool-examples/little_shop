class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name, :address, :city, :state, :zip

  def self.top_three_items
    Merchant.items.order
  end
end
