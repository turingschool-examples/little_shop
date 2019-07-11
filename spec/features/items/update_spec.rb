require 'rails_helper'

RSpec.describe 'Update Item Page' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      visit "/items/#{@ogre.id}/edit"
    end

    it 'I can click a link to get to an item edit page' do
      visit item_path(@ogre)

      click_link 'Update Item'

      expect(current_path).to eq(edit_item_path(@ogre))
    end

    it 'I can edit the items information' do
      name = 'Giant'
      description = "I'm a Giant!"
      price = 25
      image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
      inventory = 12

      visit edit_item_path(@ogre)

      fill_in 'Name', with: name
      fill_in 'Description', with: description
      fill_in 'Price', with: price
      fill_in 'Image', with: image
      fill_in 'Inventory', with: inventory
      click_button 'Update Item'

      expect(current_path).to eq(item_path(@ogre))
      expect(page).to have_content(name)
      expect(page).to have_content(description)
      expect(page).to have_content("Price: #{number_to_currency(price)}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{inventory}")
    end

    it "I cannot update an item without a name" do
      description = "I'm an Ogre!"
      price = 20
      image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
      inventory = 5

      fill_in 'Name', with: ""
      fill_in 'Description', with: description
      fill_in 'Price', with: price
      fill_in 'Image', with: image
      fill_in 'Inventory', with: inventory
      click_button 'Update Item'


      expect(page).to have_content("Name cannot be missing")
    end

    it "I cannot update an item without inventory" do
      description = "I'm an Ogre!"
      price = 20
      image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'

      fill_in 'Name', with: "Ogre"
      fill_in 'Description', with: description
      fill_in 'Price', with: price
      fill_in 'Image', with: image
      fill_in 'Inventory', with: ""
      click_button 'Update Item'

      expect(page).to have_content("Inventory must be a valid number")
    end
  end
end
