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

    describe "#remove_item" do
      it "removes the item completely from the cart" do
        cart = Cart.new(nil)

        cart.add_item(2)
        cart.add_item(2)
        cart.add_item(4)
        cart.add_item(5)

        cart.remove_item(2)

        expected = {
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

    describe "#item_ids" do
      it "returns an array of the item ids" do
        cart = Cart.new("1" => 2, "3" => 4)

        expect(cart.item_ids).to eq([1, 3])
      end
    end

    describe "#subtotal" do
      it "calculates the total cost of a particular item" do

        megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

        ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )

        # Ask instructors why our cart didn't automatically initialize with Hash.new(0)
        cart = Cart.new(Hash.new(0))

        cart.add_item(ogre.id)
        expect(cart.subtotal(ogre.id)).to eq(20)

        cart.add_item(ogre.id)
        expect(cart.subtotal(ogre.id)).to eq(40)
      end
    end

    describe "#grandtotal" do
      it "calculates the total cost of all items in the cart" do

        megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

        hippo = brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )

        # Ask instructors why our cart didn't automatically initialize with Hash.new(0)
        cart = Cart.new(Hash.new(0))

        cart.add_item(ogre.id)
        cart.add_item(ogre.id)

        cart.add_item(hippo.id)

        cart.subtotal(ogre.id)
        cart.subtotal(hippo.id)

        expect(cart.grandtotal([ogre.id, hippo.id])).to eq(90)
      end
    end
  end
end
