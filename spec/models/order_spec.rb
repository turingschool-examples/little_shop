require 'rails_helper'

RSpec.describe Order do
  describe 'Relationships' do
    it {should have_many(:items).through(:order_items)}
  end

  before(:each) do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @jori = Order.create!(name: "Jori", address: "12 Market St", city: "Denver", state: "CO", zipcode: "80021")
    @sejin = Order.create!(name: "Sejin", address: "12 Market St", city: "Las Vegas", state: "NV", zipcode: "80021")
    @order_item = @sejin.order_items.create!(quantity: 2, price: @ogre.price, item_id: @ogre.id)
    @jori.items << @ogre
    @sejin.items << @hippo
    @sejin.items << @ogre
    @sejin.items << @ogre
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
  end

  describe "desired_quantity" do
    it "should return an integer of desired quantity of item in an order" do
      expect(@sejin.desired_quantity(@ogre.id, @sejin.id)).to eq(2)
    end
  end

  describe "subtotal" do
    it "should return a float of order's item's subtotal" do
      expect(@sejin.subtotal(@ogre.id, @sejin.id)).to eq(40.0)
    end
  end

  describe "grand_total" do
    it "should return a float of order's grand total" do
      expect(@sejin.grand_total).to eq(120.0)
    end
  end
end
