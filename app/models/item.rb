class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  validates_presence_of :name, :description, :price, :image, :inventory

  def average_rating
    self.reviews.average(:rating)
  end

  def sorted_reviews
    sorted_reviews = self.reviews.order(:rating)
    [sorted_reviews[0..2] || [], sorted_reviews[-3..-1] || []]
  end
end
