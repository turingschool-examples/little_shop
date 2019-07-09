require 'rails_helper'

RSpec.describe 'Existing Merchant Update' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      visit "/merchants/#{@megan.id}/edit"
    end

    it 'I can link to an edit merchant page from merchant show page' do
      visit "/merchants/#{@megan.id}"

      click_button 'Edit'

      expect(current_path).to eq("/merchants/#{@megan.id}/edit")
    end

    it 'I can use the edit merchant form to update the merchant information' do
      visit "/merchants/#{@megan.id}/edit"

      name = 'Megans Monsters'
      address = '321 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Update Merchant'

      expect(current_path).to eq("/merchants/#{@megan.id}")
      expect(page).to have_content(name)
      expect(page).to_not have_content(@megan.name)

      within '.address' do
        expect(page).to have_content(address)
        expect(page).to have_content("#{city} #{state} #{zip}")
      end
    end

    it "I can't submit without a name" do

      address = '123 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218

      fill_in 'Name', with: ""
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Update Merchant'
      expect(page).to have_content("Name cannot be missing")
    end

    it "I can't submit without an address" do

      name = 'Megans Marmalades'
      city = "Denver"
      state = "CO"
      zip = 80218

      fill_in 'Name', with: name
      fill_in 'Address', with: ""
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Update Merchant'

      expect(page).to have_content("Address cannot be missing")
    end

    it "I can't submit without an address" do

      name = 'Megans Marmalades'
      address = '123 Main St'
      state = "CO"
      zip = 80218

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'State', with: state
      fill_in 'City', with: ""
      fill_in 'Zip', with: zip

      click_button 'Update Merchant'

      expect(page).to have_content("City cannot be missing")
    end

    it "I can't submit without an address" do

      name = 'Megans Marmalades'
      address = '123 Main St'
      city = "Denver"
      zip = 80218

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: ""
      fill_in 'Zip', with: zip

      click_button 'Update Merchant'

      expect(page).to have_content("State cannot be missing")
    end

    it "I can't submit without an address" do

      name = 'Megans Marmalades'
      address = '123 Main St'
      city = "Denver"
      state = "CO"

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: ""

      click_button 'Update Merchant'

      expect(page).to have_content("Zip must be valid.")
    end
  end
end
