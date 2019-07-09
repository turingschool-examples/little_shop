require 'rails_helper'

RSpec.describe 'New Merchant Creation' do
  describe 'As a Visitor' do
    it 'I can link to a new merchant page from merchant index' do
      visit merchants_path

      click_link 'New Merchant'

      expect(current_path).to eq(new_merchant_path)
    end

    it 'I can use the new merchant form to create a new merchant' do
      visit new_merchant_path

      name = 'Megans Marmalades'
      address = '123 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218
      click_button 'Create Merchant'

      expect(page).to have_content("Please enter a valid zip code.")

      fill_in :zip, with: zip
      click_button 'Create Merchant'

      expect(page).to have_content("Missing name!")

      fill_in :name, with: name
      click_button 'Create Merchant'

      expect(page).to have_content("Missing address!")

      fill_in :address, with: address
      click_button 'Create Merchant'

      expect(page).to have_content("Missing city!")

      fill_in :city, with: city
      click_button 'Create Merchant'

      expect(page).to have_content("Missing state!")

      fill_in :state, with: state
      click_button 'Create Merchant'

      expect(current_path).to eq(merchants_path)
      within "#merchant-#{Merchant.last.id}" do
        expect(page).to have_link(name)
      end
    end

    it 'I see an error message if I enter a bad zip' do
      visit new_merchant_path

      name = 'Megans Marmalades'
      address = '123 Main St'
      city = "Denver"
      state = "CO"

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: 8021

      click_button 'Create Merchant'

      expect(page).to have_content("Please enter a valid zip code.")
      expect(page).to have_button('Create Merchant')

      fill_in 'Zip', with: '8021a'

      click_button 'Create Merchant'

      expect(page).to have_content( "Please enter a valid zip code.")
      expect(page).to have_button('Create Merchant')
    end
  end
end
