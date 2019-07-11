require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit merchants_path

      within 'nav' do
        click_link 'Items'
      end

      expect(current_path).to eq(items_path)

      within 'nav' do
        click_link 'Merchants'
      end

      expect(current_path).to eq(merchants_path)

      within 'nav' do
        click_link 'Cart(0)'
      end

      expect(current_path).to eq(cart_path)
    end
  end
end
