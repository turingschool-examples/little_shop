require 'rails_helper'

RSpec.describe Cart do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @cart = Cart.new({@hippo.id.to_s => 2, @ogre.id.to_s => 3})
  end

  describe '#contents' do
    it 'should return empty contents' do
      expect(Cart.new(nil).contents).to eq({})
    end

    it 'should return cart contents' do
      expect(@cart.contents).to eq({@hippo.id.to_s => 2, @ogre.id.to_s => 3})
    end
  end

  describe "#total_count" do
    it "calculates the total number of items it holds" do
      expect(@cart.total_count).to eq(5)
    end
  end

  describe "#add_item" do
    it "adds a item to its contents" do
      @cart.add_item(@hippo.id)
      @cart.add_item(@ogre.id)

      expect(@cart.contents).to eq({@hippo.id.to_s => 3, @ogre.id.to_s => 4})
    end
  end

  describe '#count_of' do
    it 'returns the count of this item in the cart' do
      expect(Cart.new({}).count_of(5)).to eq(0)
    end
  end
end
