require 'rails_helper'

RSpec.describe 'New Order' do
  describe 'As a visitor' do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )    
    end

    describe 'When I click on "Create Order" an order is created' do
      it "I am redirected to that order's show page" do

        visit item_path(@ogre)
        click_button 'Add to Cart'
        visit item_path(@ogre)
        click_button 'Add to Cart'
        visit item_path(@giant)
        click_button 'Add to Cart'

        visit cart_path
        click_button 'Checkout'

        fill_in 'Name', with: "Jori"
        fill_in 'Address', with: "1234 Market St"
        fill_in 'City', with: "Denver"
        fill_in 'State', with: "CO"
        fill_in 'Zipcode', with: "80021"

        click_button "Create Order"

        order = Order.last

        within ".address" do
          expect(current_path).to eq(order_path(order))
          expect(page).to have_content("Jori")
          expect(page).to have_content("1234 Market St")
        end

        within "#item-#{@ogre.id}" do
          expect(page).to have_content(@ogre.name)
          expect(page).to have_content(@ogre.merchant.name)
          expect(page).to have_content(@ogre.price)
          expect(page).to have_content(order.desired_quantity(@ogre.id, order.id))
          expect(page).to have_content(order.subtotal(@ogre.id, order.id))
        end

        within "#item-#{@giant.id}" do
          expect(page).to have_content(@giant.name)
          expect(page).to have_content(@giant.merchant.name)
          expect(page).to have_content(@giant.price)
          expect(page).to have_content(order.desired_quantity(@giant.id, order.id))
          expect(page).to have_content(order.subtotal(@giant.id, order.id))
        end

        expect(page).to have_content(order.grand_total)
        expect(page).to have_content(order.created_at)
      end
    end
  end
end
