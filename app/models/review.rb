class Review < ApplicationRecord
  belongs_to :item
  validates_presence_of :title, :content, :rating

  def self.average_rating(reviews)
    reviews.average(:rating)
  end

  def self.sort(reviews)
    sorted_reviews = reviews.order(:rating)
    [sorted_reviews[0..2] || [], sorted_reviews[-3..-1] || []]
  end
end
