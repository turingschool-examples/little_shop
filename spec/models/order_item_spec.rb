require "rails_helper"

RSpec.describe OrderItem, type: :model do
  describe "relationships" do
    it { should belong_to :order }
    it { should belong_to :item }
  end

  before(:each) do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

    @new_order = Order.create!(name: "Valentino Valentine", address: "1111 Lovers Lane", city: "Heaven", state: "Hawaii", zip: 77777)

    @order_item_1 = OrderItem.create!(order: @new_order, item: @ogre, quantity: 2, price_per_item: 20)
    @order_item_2 = OrderItem.create!(order: @new_order, item: @hippo, quantity: 1, price_per_item: 50)
  end

  describe "instance methods" do
    describe "#subtotal" do
      it "calculates the subtotal (price per item * quantity) of each item" do
        expect(@order_item_1.subtotal).to eq(40)
        expect(@order_item_2.subtotal).to eq(50)
      end
    end
  end

  describe "class methods" do
    describe "::grandtotal" do
      it "calculates the grand total of what everything in the cart will cost" do
        expect(OrderItem.grandtotal(@new_order)).to eq(90)
      end
    end
  end
end
