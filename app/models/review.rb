class Review < ApplicationRecord
belongs_to :item

validates_presence_of :title
validates_presence_of :rating, maximum: 5
validates_presence_of :body

end
