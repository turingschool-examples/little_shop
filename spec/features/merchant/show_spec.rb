require 'rails_helper'

RSpec.describe 'Merchant Show Page' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      visit merchant_path(@megan)
    end

    it 'I see merchant name and address' do
      within 'h1' do
        expect(page).to have_content(@megan.name)
      end

      within '.address' do
        expect(page).to have_content(@megan.address)
        expect(page).to have_content("#{@megan.city} #{@megan.state} #{@megan.zip}")
      end
    end

    it 'I see a link to this merchants items' do
      expect(page).to have_button("View Items")
      expect(page).to have_button("New Item")
      expect(page).to have_button("Edit")
      expect(page).to have_button("Delete")

      click_button "New Item"
      expect(current_path).to eq(new_item_path(@megan.id))

      visit merchant_path(@megan.id)
      click_button "View Items"
      expect(current_path).to eq(merchant_items_path(@megan.id))

      visit merchant_path(@megan.id)
      click_button "Edit"
      expect(current_path).to eq(edit_merchant_path(@megan.id))

      visit merchant_path(@megan.id)
      click_button "Delete"
      expect(current_path).to eq(merchants_path)
    end

    it 'I see the top rated items for this merchant' do
      ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
      review_1 = ogre.reviews.create!(title: 'Amazing!', content: 'The best Ogre I ever saw!', rating: 2)
      visit merchant_path(@megan)

      within "#top-items" do
        expect(page.all('h2')[0]).to have_link("Ogre")
      end

      giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      review_2 = giant.reviews.create!(title: 'Better than amazing!', content: 'The best Giant anyone ever saw!', rating: 3)
      visit merchant_path(@megan)

      within "#top-items" do
        expect(page.all('h2')[1]).to have_link("Ogre")
        expect(page.all('h2')[0]).to have_link("Giant")
      end

      hippo = @megan.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      review_3 = hippo.reviews.create!(title: 'Better than amazing!', content: 'The best Ogre anyone ever saw!', rating: 5)
      visit merchant_path(@megan)

      within "#top-items" do
        expect(page.all('h2')[2]).to have_link("Ogre")
        expect(page.all('h2')[1]).to have_link("Giant")
        expect(page.all('h2')[0]).to have_link("Hippo")
      end

      elephant = @megan.items.create!(name: 'Elephant', description: "I'm an Elephant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      review_4 = elephant.reviews.create!(title: 'Better than amazing!', content: 'The best Ogre anyone ever saw!', rating: 4)
      visit merchant_path(@megan)

      within "#top-items" do
        expect(page.all('h2')[2]).to have_link("Giant")
        expect(page.all('h2')[0]).to have_link("Hippo")
        expect(page.all('h2')[1]).to have_link("Elephant")
      end
      expect(page).to_not have_content("Ogre")
    end
  end
end
