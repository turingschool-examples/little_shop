require 'rails_helper'

RSpec.describe 'Add Item to Cart' do
  describe "When I have items in my cart and I visit my cart " do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    it "I see a button or link to increment the count of items I want to purchase" do
      cart = Cart.new(nil)

      visit "/items/#{@ogre.id}"
      click_button "Add to Cart"

      visit "/items/#{@ogre.id}"
      click_button "Add to Cart"

      visit "/items/#{@giant.id}"
      click_button "Add to Cart"

      visit cart_path
      expect(current_path).to eq(cart_path)
# save_and_open_page

      within("#item-#{@giant.id}") do
        # save_and_open_page
        fill_in 'Quantity:', with: 2
        click_button 'Update Item'
        expect(current_path).to eq(cart_path)
        expect(find_field('Quantity:').value).to eq "2"
      end

      expect(page).to have_content("Cart(4)")
    end

    # it "I cannot increment the count beyond the item's inventory size" do
    #
    # end
  end
end
