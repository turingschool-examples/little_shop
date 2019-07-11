require 'rails_helper'

RSpec.describe 'Emptying Cart' do
  describe "When I click the link to empty my cart" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    it "Items have been removed from my cart" do
      visit item_path(@ogre)
      click_button "Add to Cart"

      visit item_path(@giant)
      click_button "Add to Cart"

      click_on "Cart(2)"

      click_on "Empty Cart"

      expect(current_path).to eq(cart_path)
      expect(page).to have_content('Cart(0)')
      expect(page).not_to have_content(@ogre.name)
    end

    describe "When I add no items to my cart" do
      it "I do not see the link to empty my cart" do

        visit cart_path

        expect(page).not_to have_content("Empty Cart")
      end
    end
  end
end
