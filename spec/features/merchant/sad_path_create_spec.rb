equire 'rails_helper'

RSpec.describe 'New Merchant Creation' do
  describe 'As a Visitor' do
    it 'If i do not fill out the form completely, I cannot create a new merchant' do
      visit '/merchants/new'

      name = 'Megans Marmalades'
      address = '123 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218

      fill_in 'Name', with: nil
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Create Merchant'

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_link(name)
    end
  end
end
