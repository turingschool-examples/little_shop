require 'rails_helper'

RSpec.describe "Cart Creation" do
  describe "As a visitor" do
    describe "When I visit an item's show page from the items index" do
      before(:each) do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        visit item_path(@ogre)
        click_button 'Add to Cart'
      end

      it "I see a link or button to add this item to my cart" do
        expect(current_path).to eq(items_path)
        expect(page).to have_content("You now have 1 #{@ogre.name} in your cart.")
      end

      it 'The cart indicator in the navigation bar increments my cart count' do
        expect(page).to have_content("Cart(1)")
      end
    end
  end
end
