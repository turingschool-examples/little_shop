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

      fill_in 'Name', with: name
      fill_in 'Address', with: address

      click_button 'Update Merchant'

      expect(current_path).to eq(merchant_path(@megan))
      expect(page).to_not have_content(@megan.name)
      expect(page).to_not have_content(@megan.address)

      within 'h1' do
        expect(page).to have_content(name)
      end

      within '.address' do
        expect(page).to have_content(address)
        expect(page).to have_content("#{@megan.city} #{@megan.state} #{@megan.zip}")
      end
    end
  end
end
