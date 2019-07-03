require "rails_helper"

RSpec.describe Cart, type: :model do
  describe "instance methods" do
    describe "#contents" do
      it "returns an empty hash" do
        cart = Cart.new(nil)

        expect(cart.contents).to eq({})
      end

      it "returns a hash when contents exist" do
        cart = Cart.new("1" => 2, "3" => 4)

        expected = {
          "1" => 2,
          "3" => 4,
        }

        expect(cart.contents).to eq(expected)
      end
    end

    describe "#add_item" do
      it "adds the items to the cart" do
        cart = Cart.new(nil)

        cart.add_item(2)
        cart.add_item(2)
        cart.add_item(4)
        cart.add_item(5)

        expected = {
          "2" => 2,
          "4" => 1,
          "5" => 1
        }

        expect(cart.contents).to eq(expected)
      end
    end

    describe "#total" do
      it "calculates the count of items" do
        cart = Cart.new("1" => 2, "3" => 4)

        expect(cart.total).to eq(6)
      end
    end
    
    describe "#item_count" do
      it "returns the quantity of an item" do
        cart = Cart.new("1" => 2, "3" => 4)

        expect(cart.item_count(3)).to eq(4)
      end
    end
  end
end
