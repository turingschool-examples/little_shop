require 'rails_helper'

RSpec.describe 'Item Show Page' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    it "I can see the items details" do
      visit "/items/#{@ogre.id}"

      expect(page).to have_content(@ogre.name)
      expect(page).to have_content(@ogre.description)
      expect(page).to have_content("Price: #{number_to_currency(@ogre.price)}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{@ogre.inventory}")
      expect(page).to have_content("Sold by: #{@megan.name}")
      expect(page).to have_link(@megan.name)
    end

    it "I see a list of reviews for that item with title, content, rating." do
      review_1 = @hippo.reviews.create!(title: "Hippo Review-1", content: "I loved my brand new Hippo.", rating: 5)
      review_2 = @hippo.reviews.create!(title: "Hippo Review-2", content: "I LOATHED my brand new Hippo.", rating: 1)

      visit "/items/#{@hippo.id}"
      save_and_open_page
      within "#review-#{review_1.id}" do
        expect(page).to have_content("Title: #{review_1.title}")
        expect(page).to have_content("Description: #{review_1.content}")
        expect(page).to have_content("Rating: #{review_1.rating}")
      end

      within "#review-#{review_2.id}" do
        expect(page).to have_content("Title: #{review_2.title}")
        expect(page).to have_content("Description: #{review_2.content}")
        expect(page).to have_content("Rating: #{review_2.rating}")
      end
    end
  end
end
