require 'rails_helper'

RSpec.describe 'Merchant Show Page' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @order1 = Order.create!(name: 'PaulieP', address: 'yo yo st', city: 'Denver', state: 'CO', zip: 80218)
      @order2 = Order.create!(name: 'Kanye', address: 'Lime Lite st', city: 'Chicago', state: 'IL', zip: 90210)
      @order3 = Order.create!(name: 'Me', address: 'yo yo st', city: 'Denver', state: 'CO', zip: 90210)
      @item_order1 = @giant.item_orders.create!(order_id: @order1.id, item_id: @giant.id, quantity: 2, price: @giant.price)
      @item_order2 = @ogre.item_orders.create!(order_id: @order2.id, item_id: @ogre.id, quantity: 3, price: @ogre.price)
      @item_order3 = @ogre.item_orders.create!(order_id: @order3.id, item_id: @ogre.id, quantity: 4, price: @ogre.price)

    end

    it 'I see a count of items for that merchant' do
      visit "/merchants/#{@megan.id}"
      expect(@megan.count_items).to eq(2)
      expect(page).to have_content(@megan.name)

      within "#statistics" do
        expect(page).to have_content("Number of items: #{@megan.count_items}")
      end

    end

    it 'I see average price of items for that merchant' do
      visit "/merchants/#{@megan.id}"
      expect(@megan.avg_price_items).to eq(35)

      within "#statistics" do
        expect(page).to have_content("Average Price of Items: #{@megan.avg_price_items}")
      end
    end

    it 'I see distinct cities where the merchants have orders' do
      visit "/merchants/#{@megan.id}"
      expect(@megan.cities_ordered).to eq("Chicago, Denver")

      within "#statistics" do
        expect(page).to have_content("Cities Ordered From: #{@megan.cities_ordered}")
      end
    end

  end
end
