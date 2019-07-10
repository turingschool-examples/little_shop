require 'rails_helper'

RSpec.describe "Order Show Page" do
  describe "As a visitor, when I fill out the new order form and click 'Create Order'" do
    describe "An order is created and saved in the database, and I am redirected to the orders show page" do
      it "I see all the information about the order" do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

        @order_1 = Order.create!(name: 'John Smith', address: '123 Donut St', city: 'Denver', state: 'CO', zip: 22222)

        @order_item_1 = OrderItem.create!(item: @ogre, order: @order_1, price: @ogre.price, quantity: 2)

        visit item_path(@ogre)
        click_button "Add #{@ogre.name} to Cart"
        visit cart_path
        click_link "Checkout"

        name = "John Smith"
        address = "123 Donut St"
        city = "Denver"
        state = "CO"
        zip = 22222

        fill_in 'Name', with: name
        fill_in 'Address', with: address
        fill_in 'City', with: city
        fill_in 'State', with: state
        fill_in 'Zip', with: zip
        click_button 'Create Order'
        new_order = Order.last
        new_order_item = OrderItem.last

        expect(current_path).to eq(order_path(new_order))
        expect(page).to have_content(@ogre.name)
        expect(page).to have_content(@megan.name)
        expect(page).to have_content(@order_item_1.price)
        expect(page).to have_content(@order_item_1.quantity)
        expect(page).to have_content("Subtotal: #{new_order_item.subtotal}")
        expect(page).to have_content("Grand Total: #{new_order.grand_total}")
      end
    end
  end
end
