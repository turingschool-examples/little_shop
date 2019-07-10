require 'rails_helper'

RSpec.describe "Merchat Statistics" do
  describe "As a visitor" do
    describe "When I visit a merchants show page" do
      before(:each) do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        @jori = Order.create!(name: "Jori", address: "12 Market St", city: "Denver", state: "CO", zipcode: "80021")
        @sejin = Order.create!(name: "Sejin", address: "12 Market St", city: "LA", state: "CO", zipcode: "80021")
        @jori.items << @ogre
        @sejin.items << @giant
        visit merchant_path(@megan)
      end
      it "I see Statistics for that merchant" do
        expect(page).to have_content(@megan.items.count)
        expect(page).to have_content(@megan.average_price)
        expect(page).to have_content(@jori.city)
        expect(page).to have_content(@sejin.city)
      end
    end
  end
end
