require 'rails_helper'

RSpec.describe 'Review Creation' do
  describe "When I visit an item's show page" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end
    it "I see a link to add a new review for this item." do
      visit "/items/#{@ogre.id}"
      click_on "Add New Review"

      expect(current_path).to eq("/items/#{@ogre.id}/review/new")

      fill_in 'Title', with: "Ogres are Awesome!!!"
      fill_in 'Rating', with: 5
      fill_in 'Content', with: "Megan's Marmolades has the best Ogre's in the buisness! Ogre's pedigree was as advertised."

      click_on "Create Review"
      expect(current_path).to eq("/items/#{@ogre.id}")
    end
  end
end
