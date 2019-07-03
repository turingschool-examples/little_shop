class Item < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :name, :description, :price, :image, :inventory
end
