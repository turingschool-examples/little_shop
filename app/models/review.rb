class Review < ApplicationRecord
  belongs_to :item
  validates_presence_of :title, :content, :rating

  def self.average_rating(reviews)
    tot = reviews.sum {|review| review.rating}.to_f
    (tot / reviews.length).round(1)
  end

  def self.sort(reviews)
    sorted_reviews = reviews.sort {|a,b| a.rating <=> b.rating}
    [sorted_reviews[0..2] || [], sorted_reviews[-3..-1] || []]
  end
end
