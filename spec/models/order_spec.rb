require 'rails_helper'

RSpec.describe Order do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}

  end
  describe 'Relationships' do
    it { should have_many :order_items }
    it { should have_many(:items).through(:order_items) }
  end

  describe 'instance methods' do
    it '.grand_total' do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @order_1 = Order.create!(name: 'John Smith', address: '123 Donut St', city: 'Denver', state: 'CO', zip: 22222)
      @order_item_1 = OrderItem.create!(item: @ogre, order: @order_1, price: @ogre.price, quantity: 2)
      @order_item_2 = OrderItem.create!(item: @giant, order: @order_1, price: @giant.price, quantity: 2)


      expect(@order_1.grand_total).to eq(140)
    end
  end
end
