require 'rails_helper'


RSpec.describe Cart do
  describe 'instance methods' do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @cart = Cart.new(nil)
      @cart.add_item(@ogre.id)
      @cart.add_item(@ogre.id)
      @cart.add_item(@giant.id)
    end


    describe '#add_item' do
      it 'adds an item to the cart' do
        expected = {
          @ogre.id.to_s => 2,
          @giant.id.to_s => 1,
          @hippo.id.to_s => 1
        }
        @cart.add_item(@hippo.id.to_s)
        expect(@cart.contents).to eq(expected)
      end
    end

    describe '#remove_item' do
      it 'removes an item from the cart' do
        expected = {
          @giant.id.to_s => 1,
        }
        @cart.remove_item(@ogre.id.to_s)
        expect(@cart.contents).to eq(expected)
      end
    end

    describe '#increase_count' do
      it 'it increases item quantity' do
        expected = {
          @ogre.id.to_s => 3,
          @giant.id.to_s => 1,
        }
        @cart.increase_count(@ogre.id.to_s)
        expect(@cart.contents).to eq(expected)
      end
    end

    describe '#decrease_count' do
      it 'it decreases item quantity' do
        expected = {
          @ogre.id.to_s => 1,
          @giant.id.to_s => 1,
        }
        @cart.decrease_count(@ogre.id.to_s)
        expect(@cart.contents).to eq(expected)
      end
    end

    describe '#total' do
      it 'shows total cost of allitems in cart' do
        expect(@cart.total).to eq(3)
      end
    end

    describe '#item_count' do
      it 'shows number of each item in cart' do
        expect(@cart.item_count(@ogre.id)).to eq(2)
         expect(@cart.item_count(@giant.id)).to eq(1)
      end
    end
  end
end
