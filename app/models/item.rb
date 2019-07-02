class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
end
