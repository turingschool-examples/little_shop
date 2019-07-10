require 'rails_helper'

RSpec.describe 'Item Show Page' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @review_1 = @ogre.reviews.create!(title: 'Amazing!', content: 'The best Ogre I ever saw!', rating: 5)
      @review_2 = @ogre.reviews.create!(title: 'Pretty good!', content: 'The best Ogre anyone ever saw!', rating: 4)
      visit item_path(@ogre)
    end

    it "I can see the items details" do
      expect(page).to have_content(@ogre.name)
      expect(page).to have_content(@ogre.description)
      expect(page).to have_content("Price: #{number_to_currency(@ogre.price)}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{@ogre.inventory}")
      expect(page).to have_content("Sold by: #{@megan.name}")
      expect(page).to have_link(@megan.name)
    end

    it "I can see item links" do
      expect(page).to have_link("Add to Cart")
      expect(page).to have_link("Update Item")
      expect(page).to have_link("Delete")
    end

    it "I can sort the item's reviews" do
      click_button 'Ascending'

      within '.reviews' do
        expect(page.all('h2')[0]).to have_content(@review_2.title)
        expect(page.all('h2')[1]).to have_content(@review_1.title)
      end

      click_button 'Descending'

      within '.reviews' do
        expect(page.all('h2')[0]).to have_content(@review_1.title)
        expect(page.all('h2')[1]).to have_content(@review_2.title)
      end
    end
  end
end
