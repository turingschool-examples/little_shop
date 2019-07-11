require 'rails_helper'

RSpec.describe Cart do
  describe 'when I visit the item show page' do
    describe 'I click the Add to Cart link' do
      it "I can add the item to the cart" do
        megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 2)
        visit item_path(ogre)

        expect(page).to have_content("Cart: 0")

        click_link "Add to Cart"

        expect(page).to have_content("You now have 1 Ogre in your cart.")
        expect(page).to have_content("Cart: 1")
        expect(current_path).to eq(items_path)

        visit item_path(ogre)
        click_link "Add to Cart"

        expect(page).to have_content("You now have 2 Ogres in your cart.")
        expect(page).to have_content("Cart: 2")

        visit item_path(ogre)
        click_link "Add to Cart"

        expect(page).to have_content("There is no more stock of Ogre available.")
        expect(current_path).to eq(items_path)
      end
    end
  end
end
