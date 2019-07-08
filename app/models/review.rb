class Review < ApplicationRecord
belongs_to :item

validates_presence_of :title
validates_presence_of :rating, maximum: 5
validates_presence_of :body


def self.top_three_rated(item)
  item.reviews.order(rating: :desc).limit(3)
end

def self.bottom_three_rated(item)
  item.reviews.order(rating: :asc).limit(3)
end

def self.average_rating(item)
  item.reviews.average(:rating)
end

end
