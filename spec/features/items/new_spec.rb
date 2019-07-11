require 'rails_helper'

RSpec.describe 'New Merchant Item' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      visit new_merchant_item_path(@megan)
    end

    it 'I can click a link to a new item form page' do
      visit merchant_items_path(@megan)

      click_link 'New Item'

      expect(current_path).to eq(new_merchant_item_path(@megan))
    end

    it 'I can create an  item for a merchant' do
      name = 'Ogre'
      description = "I'm an Ogre!"
      price = 20
      image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
      inventory = 5

      fill_in 'Name', with: name
      fill_in 'Description', with: description
      fill_in 'Price', with: price
      fill_in 'Image', with: image
      fill_in 'Inventory', with: inventory
      click_button 'Create Item'

      expect(current_path).to eq(merchant_items_path(@megan))
      expect(page).to have_link(name)
      expect(page).to have_content(description)
      expect(page).to have_content("Price: #{number_to_currency(price)}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{inventory}")
    end

    it "I cannot create an item without a name" do
      description = "I'm an Ogre!"
      price = 20
      image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
      inventory = 5

      fill_in 'Description', with: description
      fill_in 'Price', with: price
      fill_in 'Image', with: image
      fill_in 'Inventory', with: inventory
      click_button 'Create Item'


      expect(page).to have_content("Name cannot be missing")
    end

    it "I cannot create an item without inventory" do
      description = "I'm an Ogre!"
      price = 20
      image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'

      fill_in 'Name', with: "Ogre"
      fill_in 'Description', with: description
      fill_in 'Price', with: price
      fill_in 'Image', with: image
      click_button 'Create Item'

      expect(page).to have_content("Inventory must be a valid number")
    end
  end
end
