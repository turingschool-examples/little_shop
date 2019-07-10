require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}
  end

  describe "Merchant Methods" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 10 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 40, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 10 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 10 )
      @order_1 = Order.create(name: 'Jake', address: '123 froggo street', city: 'Greenbay', state: 'WI', zip: 22908)
      @order_2 = Order.create(name: 'Kelly', address: '123 doggo street', city: 'Naples', state: 'FL', zip: 34109)
      @order_items_1 = OrderItem.create(order: @order_1, item: @ogre, count: 3, amount: 20)
      @order_items_2 = OrderItem.create(order: @order_1, item: @giant, count: 1, amount: 40)
      @order_items_3 = OrderItem.create(order: @order_2, item: @hippo, count: 9, amount: 50)
    end
  end

  describe "total_inventory" do
    it "Check the total inventory of a merchant in an order" do
      expect(@megan.total_inventory).to eq(4)
      expect(@brian.total_inventory).to eq(9)
    end
  end

  describe "ave_item_price" do
    it "Get the average item price of a merchants items in an order" do
      expect(@megan.ave_item_price).to eq(25)
      expect(@brian.ave_item_price).to eq(50)
    end
  end

  describe "cities" do
    it "Find the distinct cities of a merchants sold items" do
      expect(@megan.cities).to eq(["Greenbay"])
      expect(@brian.cities).to eq(["Naples"])
    end
  end

  describe "has_items_in_orders" do
    it "Check it a merchant has items in past orders." do
      expect(@megan.has_items_in_orders?).to eq(true)
      expect(@brian.has_items_in_orders?).to eq(true)
    end
  end

end
