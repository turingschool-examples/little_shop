require 'rails_helper'

RSpec.describe 'New Order' do
  describe 'As a visitor' do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @cart = Cart.new(nil)
    end

    describe 'When I checkout from my cart' do
      it 'I see the details the detail of my cart' do

        visit item_path(@ogre)
        click_button 'Add to Cart'
        visit cart_path
        click_button 'Checkout'

        expect(current_path).to eq(orders_new_path)
        expect(page).to have_content(@ogre.name)
        expect(page).to have_content(@ogre.merchant.name)
        expect(page).to have_content(@ogre.price)
        expect(page).to have_content(@cart.item_count(@ogre.id))
        expect(page).to have_content(@cart.subtotal(@ogre.id))
        expect(page).to have_content(@cart.grand_total)

        fill_in 'Name', with: "Jori"
        fill_in 'Address', with: "1234 Market St"
        fill_in 'City', with: "Denver"
        fill_in 'State', with: "CO"
        fill_in 'Zipcode', with: "80021"

        expect(page).to have_button 'Create Order'
      end

      it 'I cannot create an order without completing the form' do

        visit item_path(@ogre)
        click_button 'Add to Cart'
        visit cart_path
        click_button 'Checkout'

        fill_in 'Address', with: "1234 Market St"
        fill_in 'City', with: "Denver"
        fill_in 'State', with: "CO"
        fill_in 'Zipcode', with: "80021"

        click_button "Create Order"

        expect(current_path).to eq(orders_new_path)
        expect(page).to have_content("Please fill in all fields.")
      end
    end
  end
end
