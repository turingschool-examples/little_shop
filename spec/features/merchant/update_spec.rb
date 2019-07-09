require 'rails_helper'

RSpec.describe 'Existing Merchant Update' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    end

    it 'I can link to an edit merchant page from merchant show page' do
      visit merchant_path(@megan)

      click_button 'Edit'

      expect(current_path).to eq(edit_merchant_path(@megan))

      expect(find_field(:name).value).to eq(@megan.name)
      expect(find_field(:address).value).to eq(@megan.address)
      expect(find_field(:city).value).to eq(@megan.city)
      expect(find_field(:state).value).to eq(@megan.state)
      expect(find_field(:zip).value).to eq(@megan.zip.to_s)

      name = 'Megans Marmalade'
      address = '321 Main St'
      city = 'Denver'
      state = 'CO'
      zip = 80204
      fill_in :zip, with: 802
      click_button 'Update Merchant'

      expect(page).to have_content('Please enter a valid zip code.')

      visit edit_merchant_path(@megan)
      fill_in :name, with: ''
      click_button 'Update Merchant'

      expect(page).to have_content("Missing name!")

      visit edit_merchant_path(@megan)
      fill_in :address, with: ''
      click_button 'Update Merchant'

      expect(page).to have_content("Missing address!")

      visit edit_merchant_path(@megan)
      fill_in :city, with: ''
      click_button 'Update Merchant'

      expect(page).to have_content("Missing city!")

      visit edit_merchant_path(@megan)
      fill_in :state, with: ''
      click_button 'Update Merchant'

      expect(page).to have_content("Missing state!")

      visit edit_merchant_path(@megan)
      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip
      click_button 'Update Merchant'

      expect(current_path).to eq(merchant_path(@megan))
      expect(page).to_not have_content(@megan.name)
      expect(page).to_not have_content(@megan.address)

      within 'h1' do
        expect(page).to have_content(name)
      end

      within '.address' do
        expect(page).to have_content(address)
        expect(page).to have_content("#{city} #{state} #{zip}")
      end
    end
  end
end
