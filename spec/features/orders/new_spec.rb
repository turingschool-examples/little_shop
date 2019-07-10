require 'rails_helper'

RSpec.describe 'New Order' do
  describe 'As a Visitor' do
    it 'I see a new order page' do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      visit item_path(@ogre)
      click_link "Add to Cart"
      visit item_path(@ogre)
      click_link "Add to Cart"
      visit cart_path
      click_link "Checkout"

      expect(page).to have_link(@ogre.name)
      expect(page).to have_link(@ogre.merchant.name)
      expect(page).to have_content("Sold by: #{@ogre.merchant.name}")
      expect(page).to have_content("Price: #{number_to_currency(@ogre.price)}")
      expect(page).to have_content('Quantity: 2')
      expect(page).to have_content('Subtotal: $40.00')
      expect(page).to have_content('Total: $40.00')

      name = 'Megan'
      address = '123 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218

      click_button 'Create Order'

      expect(page).to have_content('Missing name!')

      fill_in :name, with: name
      click_button 'Create Order'

      expect(page).to have_content('Missing address!')

      fill_in :address, with: address
      click_button 'Create Order'

      expect(page).to have_content('Missing city!')

      fill_in 'City', with: city
      click_button 'Create Order'

      expect(page).to have_content('Missing state!')

      fill_in 'State', with: state
      click_button 'Create Order'

      expect(page).to have_content('Missing zip!')

      fill_in 'Zip', with: zip
      click_button 'Create Order'

      expect(current_path).to eq(order_path(Order.last))
      within('h1') do
        expect(page).to have_content(name)
      end
      within('.address') do
        expect(page).to have_content(address)
        expect(page).to have_content(city)
        expect(page).to have_content(state)
        expect(page).to have_content(zip)
      end

      expect(page).to have_link(@ogre.name)
      expect(page).to have_link(@ogre.merchant.name)
      expect(page).to have_content("Sold by: #{@ogre.merchant.name}")
      expect(page).to have_content("Price: #{number_to_currency(@ogre.price)}")
      expect(page).to have_content('Quantity: 2')
      expect(page).to have_content('Subtotal: $40.00')
      expect(page).to have_content('Total: $40.00')
      expect(page).to have_content("Date Created: #{Time.now.to_s.split[0]}")
    end
  end
end
