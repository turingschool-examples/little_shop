require 'rails_helper'

RSpec.describe 'Review Creation' do
  describe "When I visit an item's show page" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      visit item_path(@ogre)
    end
    it "I see a link to add a new review for this item." do
      click_on "Add New Review"

      expect(current_path).to eq("/items/#{@ogre.id}/reviews/new")

      fill_in 'Title', with: "Ogres are Awesome!!!"
      page.select(5, :from => 'Rating')
      fill_in 'Content', with: "Megan's Marmolades has the best Ogre's in the buisness! Ogre's pedigree was as advertised."

      click_on "Create Review"
      expect(current_path).to eq(item_path(@ogre))

      review = Review.last

      expect(page).to have_content("Reviews:")

      within "#review-#{review.id}" do
        expect(page).to have_content(review.title)
        expect(page).to have_content(review.rating)
        expect(page).to have_content(review.content)
      end
    end

    it "I must fill out all form fields" do
      click_on "Add New Review"

      page.select(5, :from => 'Rating')
      fill_in 'Content', with: "Megan's Marmolades has the best Ogre's in the buisness! Ogre's pedigree was as advertised."

      click_on "Create Review"
      expect(current_path).to eq("/items/#{@ogre.id}/reviews/new")
      expect(page).to have_content("Please fill in all fields.")
    end
  end
end
