require 'rails_helper'

RSpec.describe "Order Show Page" do
  describe "As a visitor, when I fill out the new order form and click 'Create Order'" do
    describe "An order is created and saved in the database, and I am redirected to the orders show page" do
      it "I see all the information about the order" do
        
      end
    end
  end
end





  # As a visitor
  # When I fill out all information on the new order page
  # And click on 'Create Order'
  # An order is created and saved in the database
  # And I am redirected to that order's show page with the following information:
  # - My name and address (shipping information)
  # - Details of the order:
  # - the name of the item
  # - the merchant I'm buying this item from
  # - the price of the item
  # - my desired quantity of the item
  # - a subtotal (price multiplied by quantity)
  # - a grand total of what everything in my cart will cost
  # - the date when the order was created
