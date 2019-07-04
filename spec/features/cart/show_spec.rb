require "rails_helper"

RSpec.describe "Cart Show Page", type: :feature do
  describe "As a vistor" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @something = @brian.items.create!(name: 'Something', description: "I'm not suppose to show up!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    describe "When I have added items to my cart" do
      it "I see all items I've added to my cart" do
        visit "/items/#{@hippo.id}"
        click_on("Add Item")

        visit "/items/#{@giant.id}"
        click_on("Add Item")

        visit "items/#{@ogre.id}"
        click_on("Add Item")

        visit "/items/#{@hippo.id}"
        click_on("Add Item")

        visit "/items/#{@hippo.id}"
        click_on("Add Item")

        expect(page).to have_content("Cart: 5")

        visit "/cart"

        expect(page).to_not have_content(@something.name)

        within "#item-#{@hippo.id}" do
          expect(page).to have_content(@hippo.name)
          expect(page).to have_css("img[src*='#{@hippo.image}']")
          expect(page).to have_content(@hippo.merchant.name)
          expect(page).to have_content(@hippo.price)
          expect(page).to have_content("Quantity: 3")
          expect(page).to have_content("Subtotal: $150.00")
        end

        within "#item-#{@giant.id}" do
          expect(page).to have_content(@giant.name)
          expect(page).to have_css("img[src*='#{@giant.image}']")
          expect(page).to have_content(@giant.merchant.name)
          expect(page).to have_content(@giant.price)
          expect(page).to have_content("Quantity: 1")
          expect(page).to have_content("Subtotal: $50.00")
        end

        within "#item-#{@ogre.id}" do
          expect(page).to have_content(@ogre.name)
          expect(page).to have_css("img[src*='#{@ogre.image}']")
          expect(page).to have_content(@ogre.merchant.name)
          expect(page).to have_content(@ogre.price)
          expect(page).to have_content("Quantity: 1")
          expect(page).to have_content("Subtotal: $20.00")
        end
        expect(page).to have_content("Grand Total: $220.00")
      end
    end
  end
end
