require 'rails_helper'

RSpec.describe 'Destroy Existing Merchant' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    it 'I can click button to destroy merchant from database' do
      visit merchant_path(@brian.id)

      click_button 'Delete'

      expect(current_path).to eq(merchants_path)
      expect(page).to_not have_content(@brian.name)
    end

    it "If a merchant has items in the orders database, I cannot delete that merchant." do
      visit item_path(@hippo)
      click_link "Add to Cart"

      visit cart_path
      click_link 'Checkout'

      visit new_order_path
      fill_in 'Name', with: 'Logan Marma'
      fill_in 'Address', with: '123 Tree St'
      fill_in 'City', with: "Denver"
      fill_in 'State', with: "CO"
      fill_in 'Zip', with: 80237

      visit "/merchants/#{@brian.id}"
      click_button 'Delete'
      expect(page).to have_content("You cannot delete this merchant.")

      visit "/merchants"
      expect(page).to have_content(@brian.name)
    end
  end
end
