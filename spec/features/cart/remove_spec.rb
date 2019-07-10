require "rails_helper"

RSpec.describe "Removing Item From Cart" do
  describe "As a visitor" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    end

    it "I can remove an item from my cart" do

      visit item_path(@ogre)
      click_button "Add to Cart"

      visit item_path(@ogre)
      click_button "Add to Cart"

      visit cart_path
      within("#item-#{@ogre.id}") do
        click_button "Remove Item"
      end

      expect(page).not_to have_content(@ogre.name)
    end
  end
end
