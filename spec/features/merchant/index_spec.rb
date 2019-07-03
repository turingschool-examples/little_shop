require 'rails_helper'

RSpec.describe 'Merchant Index Page' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @merchant1 = Merchant.create!(name: 'Kaiju', address: '1531 Madison Ave', city: 'New York', state: 'NY', zip: '10005',  image: 'https://cdn.shopify.com/s/files/1/0584/3841/products/vinyl-kaiju-dunny-battle-3-mini-figure-series-by-kidrobot-x-clutter-18_1200x.gif?v=1550786302')
      @merchant2 = Merchant.create!(name: 'Donk', address: '321 Rodeo', city: 'Beverly Hills', state: 'CA', zip: '90210', image: 'https://cdn.shopify.com/s/files/1/0584/3841/products/vinyl-kaiju-dunny-battle-3-mini-figure-series-by-kidrobot-x-clutter-17_1200x.gif?v=1550786302')

    end

    it 'I see a list of all merchants' do
      visit '/merchants'

      within "#merchant-#{@megan.id}" do
        expect(page).to have_link(@megan.name)
      end

      within "#merchant-#{@brian.id}" do
        expect(page).to have_link(@brian.name)
      end
    end

    it 'I can click a link to get to a merchants show page' do
      visit '/merchants'

      click_link @megan.name

      expect(current_path).to eq("/merchants/#{@megan.id}")
    end
  end
end
