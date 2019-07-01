require 'rails_helper'

RSpec.describe "Cart Indicator" do
  describe "As a visitor" do
    before(:each) do
      @cart = Cart.new
    end

    it "I see a cart indicator in my navigation bar" do
      visit merchants_path

      expect(page).to have_content("Cart(#{@cart.counter})")
    end

    it "The cart indicator shows a count of items in my cart" do
      visit items_path

      expect(page).to have_content("Cart(#{@cart.counter})")
    end
  end
end
