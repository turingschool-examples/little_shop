require 'rails_helper'

RSpec.describe 'Update Item Page' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    end

    it 'I can click a link to get to an item edit page' do
      visit item_path(@ogre)

      click_link 'Update Item'

      expect(current_path).to eq(edit_item_path(@ogre))
    end

    it 'I can edit the items information' do
      visit edit_item_path(@ogre)

      expect(find_field(:name).value).to eq(@ogre.name)
      expect(find_field(:description).value).to eq(@ogre.description)
      expect(find_field(:price).value).to eq(@ogre.price.to_s)
      expect(find_field(:image).value).to eq(@ogre.image)
      expect(find_field(:inventory).value).to eq(@ogre.inventory.to_s)

      name = 'Giant'
      description = "I'm a Giant!"
      price = 25

      fill_in 'Name', with: name
      fill_in 'Description', with: description
      fill_in 'Price', with: price
      click_button 'Update Item'

      expect(current_path).to eq(item_path(@ogre))
      expect(page).to_not have_content(@ogre.name)
      expect(page).to_not have_content(@ogre.description)
      expect(page).to_not have_content(@ogre.price)

      expect(page).to have_content(name)
      expect(page).to have_content(description)
      expect(page).to have_content("Price: #{number_to_currency(price)}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{@ogre.inventory}")
      expect(page).to have_content("Sold by: #{@ogre.merchant.name}")
      expect(page).to have_link(@ogre.merchant.name)
    end
  end
end
