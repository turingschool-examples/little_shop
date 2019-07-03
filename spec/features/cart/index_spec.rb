require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Cart Index Page' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    it 'I can see a list of all items' do
      visit cart_path

      expect(page).to_not have_content(@ogre.name)
      expect(page).to_not have_content(@giant.name)
      expect(page).to_not have_content(@hippo.name)
      expect(page).to have_content("Cart: 0")

      expect(page).to have_content("Your cart is empty.")
      expect(page).to_not have_link("Empty Cart")
      expect(page).to_not have_link("Checkout")

      visit item_path(@ogre)
      click_link "Add to Cart"
      visit item_path(@ogre)
      click_link "Add to Cart"
      visit item_path(@giant)
      click_link "Add to Cart"

      visit cart_path

      expect(page).to have_content("All Items in Cart")
      expect(page).to have_content("Cart: 3")
      expect(page).to have_link("Empty Cart")

      within "#item-#{@ogre.id}" do
        expect(page).to have_link(@ogre.name)
        expect(page).to have_css("img[src*='#{@ogre.image}']")
        expect(page).to have_content("Sold by: #{@megan.name}")
        expect(page).to have_link(@megan.name)
        expect(page).to have_content("Price: #{number_to_currency(@ogre.price)}")
        expect(page).to have_content("Quantity: 2")
      end

      within "#item-#{@giant.id}" do
        expect(page).to have_link(@giant.name)
        expect(page).to have_css("img[src*='#{@giant.image}']")
        expect(page).to have_content("Sold by: #{@megan.name}")
        expect(page).to have_link(@megan.name)
        expect(page).to have_content("Price: #{number_to_currency(@giant.price)}")
        expect(page).to have_content("Quantity: 1")
      end

      expect(page).to have_content("Total cost: 90")
      expect(page).to_not have_content(@hippo.name)

      click_link("Empty Cart")

      expect(page).to have_content("Your cart is empty.")
      expect(page).to have_content("Cart: 0")
      expect(page).to_not have_link("Empty Cart")
      expect(page).to_not have_content(@hippo.name)
      expect(page).to_not have_content(@ogre.name)
      expect(page).to_not have_content(@giant.name)
      expect(page).to_not have_content("Total cost: ")
    end
  end
end
