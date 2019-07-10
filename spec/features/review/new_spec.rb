# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Review' do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80_218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
  end

  describe 'As a Visitor when I visit an items show page' do
    it 'I can create a review' do
      visit "/items/#{@ogre.id}"

      expect(page).to have_button 'Add Review'

      click_button 'Add Review'

      fill_in 'Title', with: 'Great'
      fill_in 'Content', with: 'content'
      fill_in 'Rating', with: '1'
      click_button 'Submit'

      expect(current_path).to eq(item_path(@ogre.id))
      expect(page).to have_content('Title: Great')
      expect(page).to have_content('Content: content')
      expect(page).to have_content('Rating: 1')
    end

    it "Flash message generated for incomplete review" do

      visit "/items/#{@ogre.id}/reviews/new"
      fill_in 'Title', with: 'Great'
      fill_in 'Rating', with: '1'
      click_button 'Submit'

      expect(page).to have_content('Incomplete Review')
      expect(current_path).to eq("/items/#{@ogre.id}/reviews/new")
    end
  end
end
