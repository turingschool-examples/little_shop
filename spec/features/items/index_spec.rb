require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Item Index Page' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end
    it 'I can see a list of all items' do
      visit '/items'

      within "#item-#{@ogre.id}" do
        expect(page).to have_link(@ogre.name)
        expect(page).to have_content(@ogre.description)
        expect(page).to have_content("Price: #{number_to_currency(@ogre.price)}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@ogre.inventory}")
        expect(page).to have_content("Sold by: #{@megan.name}")
        expect(page).to have_css("img[src*='#{@ogre.image}']")
        expect(page).to have_link(@megan.name)
      end

      within "#item-#{@giant.id}" do
        expect(page).to have_link(@giant.name)
        expect(page).to have_content(@giant.description)
        expect(page).to have_content("Price: #{number_to_currency(@giant.price)}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@giant.inventory}")
        expect(page).to have_content("Sold by: #{@megan.name}")
        expect(page).to have_css("img[src*='#{@giant.image}']")
        expect(page).to have_link(@megan.name)
      end

      within "#item-#{@hippo.id}" do
        expect(page).to have_link(@hippo.name)
        expect(page).to have_content(@hippo.description)
        expect(page).to have_content("Price: #{number_to_currency(@hippo.price)}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@hippo.inventory}")
        expect(page).to have_content("Sold by: #{@brian.name}")
        expect(page).to have_css("img[src*='#{@hippo.image}']")
        expect(page).to have_link(@brian.name)
      end
    end

    it "I can click on the item name to go to that item's show page" do
      visit '/items'
      # visit items_path
      expect(page).to have_link(@ogre.name)
      click_link(@ogre.name)
      expect(current_path).to eq("/items/#{@ogre.id}")

      within "#item-#{@ogre.id}" do
        # expect(current_path).to eq(item_path(@ogre))
        expect(page).to have_content(@ogre.name)
        expect(page).to have_content(@ogre.description)
        expect(page).to have_content(@ogre.price)
        expect(page).to have_css("img[src*='#{@ogre.image}']")
        expect(page).to have_content("Active")
        expect(page).to have_content(@ogre.inventory)
      end

      visit '/items'

      expect(page).to have_link(@hippo.name)
      click_link(@hippo.name)
      expect(current_path).to eq("/items/#{@hippo.id}")
      #expect(current_path).to eq(item_path(@hippo))
      within "#item-#{@hippo.id}" do
        expect(page).to have_content(@hippo.name)
        expect(page).to have_content(@hippo.description)
        expect(page).to have_content(@hippo.price)
        expect(page).to have_css("img[src*='#{@hippo.image}']")
        expect(page).to have_content("Active")
        expect(page).to have_content(@hippo.inventory)
      end

      visit '/items'

      expect(page).to have_link(@giant.name)
      click_link(@giant.name)
      expect(current_path).to eq("/items/#{@giant.id}")
      #expect(current_path).to eq(item_path(@giant))

      within "#item-#{@giant.id}" do
        expect(page).to have_content(@giant.name)
        expect(page).to have_content(@giant.description)
        expect(page).to have_content(@giant.price)
        expect(page).to have_css("img[src*='#{@giant.image}']")
        expect(page).to have_content("Active")
        expect(page).to have_content(@giant.inventory)
      end
    end
  end
end
