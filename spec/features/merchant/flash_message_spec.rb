require 'rails_helper'

RSpec.describe 'Existing Merchant Update Flash Message' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    end

    it 'I see a flash message for a specific field not being filled: test 1' do
      visit "/merchants/#{@megan.id}/edit"

      name = 'Megans Monsters'
      address = '321 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218

      # fill_in 'Name', with: ""
      fill_in 'Address', with: address
      # fill_in 'City', with: ""
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Update Merchant'

      expect(current_path).to eq("/merchants/#{@megan.id}")
      expect(page).to have_content("Name can't be blank, City can't be blank")
    end

    it 'I see a flash message for a specific field not being filled: test 2' do
      visit "/merchants/#{@megan.id}/edit"

      name = 'Megans Monsters'
      address = '321 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218

      fill_in 'Name', with: ""
      # fill_in 'Address', with: address
      fill_in 'City', with: ""
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Update Merchant'

      expect(current_path).to eq("/merchants/#{@megan.id}")
      expect(page).to have_content("Address cannot be blank")
    end

  end
end
