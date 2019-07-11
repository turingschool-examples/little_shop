require 'rails_helper'

RSpec.describe 'Add Item to Cart' do
  describe "When I have items in my cart and I visit my cart " do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      visit item_path(@ogre)
      click_button "Add to Cart"
      visit item_path(@ogre)
      click_button "Add to Cart"
      visit item_path(@giant)
      click_button "Add to Cart"
      visit cart_path
    end

    it "I see a button or link to increment the count of items I want to purchase" do
      expect(current_path).to eq(cart_path)

      within("#item-#{@giant.id}") do
        fill_in 'Quantity:', with: 2
        click_button 'Update Item'
        expect(current_path).to eq(cart_path)
        expect(find_field('Quantity:').value).to eq "2"
      end

      expect(page).to have_content("Cart(4)")
    end

    it "If item id decremented to zero the item is removed from the cart" do
      within("#item-#{@giant.id}") do
        fill_in 'Quantity:', with: 0
        click_button 'Update Item'
        expect(current_path).to eq(cart_path)
      end

      expect(page).not_to have_content(@giant.name)
      expect(page).to have_content ("Item has been removed from your cart.")
    end

    it "I cannot increment the count beyond the item's inventory size" do
      within("#item-#{@giant.id}") do
        fill_in 'Quantity:', with: 20
        click_button 'Update Item'
        expect(current_path).to eq(cart_path)
        expect(find_field('Quantity:').value).not_to eq "20"
      end

      expect(page).to have_content ("Sorry, there is not enough in stock for this order.")
    end
  end
end
