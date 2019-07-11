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

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Create Merchant'

      expect(current_path).to eq(merchants_path)
      expect(page).to have_link(name)
    end

    it "I can't submit without a name" do
      visit new_merchant_path

      address = '123 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218

      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Create Merchant'

      expect(page).to have_content("Name cannot be missing")
    end

    it "I can't submit without an address" do
      visit new_merchant_path

      name = 'Megans Marmalades'
      city = "Denver"
      state = "CO"
      zip = 80218

      fill_in 'Name', with: name
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Create Merchant'

      expect(page).to have_content("Address cannot be missing")
    end

    it "I can't submit without an address" do
      visit new_merchant_path

      name = 'Megans Marmalades'
      address = '123 Main St'
      state = "CO"
      zip = 80218

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Create Merchant'

      expect(page).to have_content("City cannot be missing")
    end

    it "I can't submit without an address" do
      visit new_merchant_path

      name = 'Megans Marmalades'
      address = '123 Main St'
      city = "Denver"
      zip = 80218

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'Zip', with: zip

      click_button 'Create Merchant'

      expect(page).to have_content("State cannot be missing")
    end

    it "I can't submit without an address" do
      visit new_merchant_path

      name = 'Megans Marmalades'
      address = '123 Main St'
      city = "Denver"
      state = "CO"

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state

      click_button 'Create Merchant'

      expect(page).to have_content("Zip must be valid.")
    end
  end
end
