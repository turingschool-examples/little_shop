require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Cart Decrement Test' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    it 'I can decrement items in the cart' do
      visit item_path(@ogre)
      click_link "Add to Cart"
      visit item_path(@hippo)
      click_link "Add to Cart"
      visit item_path(@giant)
      click_link "Add to Cart"

      visit cart_path

      within "#item-#{@ogre.id}" do
        expect(page).to have_link("-")
        expect(page).to have_content("Quantity: 1")
        click_link("-")
      end

      within "#item-#{@giant.id}" do
        expect(page).to have_link("-")
        expect(page).to have_content("Quantity: 1")
        click_link("-")
      end

      expect(page).to_not have_content("Quantity: 0")
      expect(page).to_not have_content("Quantity: -1")

      within "#item-#{@hippo.id}" do
        expect(page).to have_link("-")
        expect(page).to have_content("Quantity: 1")
        click_link("-")
      end

      expect(page).to_not have_link("-")
      expect(page).to have_content("Your cart is empty.")
    end
  end
end
