require 'rails_helper'

RSpec.describe "Control Item Destruction" do
  describe "As a visitor" do
    describe "If a item has been ordered" do
      before(:each) do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @jori = Order.create!(name: "Jori", address: "12 Market St", city: "Denver", state: "CO", zipcode: "80021")
        @jori.items << @ogre
      end
      it "I cannot delete that item" do
        visit item_path(@ogre)

        click_on "Delete"

        expect(current_path).to eq(item_path(@ogre))
        expect(page).to have_content("This item has pending orders, cannot be deleted.")
      end
    end
  end
end
