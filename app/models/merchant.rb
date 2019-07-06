class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name, :address, :city, :state, :zip

  def top_three_items
    items.order(:name)[0..2]
  end
end
