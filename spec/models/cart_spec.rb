require 'rails_helper'

RSpec.describe Cart do
  describe 'instance methods' do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @jori = Order.create!(name: "Jori", address: "12 Market St", city: "Denver", state: "CO", zipcode: "80021")
      @jori.items << @ogre
      @cart = Cart.new(nil)
      @cart.add_item(@ogre.id)
      @cart.add_item(@giant.id)
      @cart.add_item(@giant.id)
      @cart.add_item(@ogre.id)
      @cart.add_item(@hippo.id)
    end

    describe '#contents' do
      it 'should return an empty hash when the contents are nil' do
        cart = Cart.new(nil)
        expect(cart.contents).to eq({})
      end

      it 'should return hash when contents exist' do
        cart = Cart.new({"12" => 2, "112" => 1})
        expect(cart.contents).to eq ({"12" => 2, "112" => 1})
      end
    end

    describe '#items' do
      it 'returns item objects' do
        expect(@cart.items).to eq([@ogre, @giant, @hippo])
      end
    end

    describe '#add_cart_to_order_items' do
      it 'should instantiate order_items' do
        expect(@cart.add_cart_to_order_items(@jori)).to eq([@ogre, @giant, @hippo])
      end
    end

    describe '#add_item' do
      it 'adds items to the cart' do

        expected = {
          @ogre.id.to_s => 2,
          @giant.id.to_s => 2,
          @hippo.id.to_s => 1
        }

        expect(@cart.contents).to eq(expected)
      end
    end

    describe '#item_count' do
      it 'should display count of items in the cart' do
        expect(@cart.item_count(@ogre.id)).to eq(2)
        expect(@cart.item_count(@giant.id)).to eq(2)
        expect(@cart.item_count(@hippo.id)).to eq(1)
      end
    end

    describe '#total' do
      it 'displays the total items in the cart' do
        expect(@cart.total).to eq(5)
      end
    end

    describe '#subtotal' do
      it 'displays the total price for each item in the cart' do
        expect(@cart.subtotal(@ogre.id)).to eq(40)
        expect(@cart.subtotal(@giant.id)).to eq(100)
        expect(@cart.subtotal(@hippo.id)).to eq(50)
      end
    end

    describe '#grand_total' do
      it 'displays the total price for all items in the cart combined' do
        expect(@cart.grand_total).to eq(190)
      end
    end

    describe '#empty?' do
      it 'returns true if empty else false' do
        expect(@cart.empty?).to eq(false)
      end
    end

    describe '#remove_item' do
      it 'removes an item from the cart' do

        expected = {
          @giant.id.to_s => 2,
          @hippo.id.to_s => 1
        }

        @cart.remove_item(@ogre.id.to_s)
        expect(@cart.contents).to eq(expected)
      end
    end

    describe '#update_quantity' do
      it 'updates the quantity of items in the cart' do

        expected = {
          @ogre.id.to_s => 2,
          @giant.id.to_s => 2,
          @hippo.id.to_s => 3
        }

        @cart.update_quantity(@hippo.id.to_s, 3)
        expect(@cart.contents).to eq(expected)
      end
    end
  end
end
