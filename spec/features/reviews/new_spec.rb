require 'rails_helper'

RSpec.describe 'New Review Creation' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @review1 = @giant.reviews.create!(title: "Damn!", rating: 5, body: "Definitely a Giant. No argument there")
      @review2 = @giant.reviews.create!(title: "Disappointed...", rating: 1, body: "Idk what I was expecting but I was disappointed.")
      @review3 = @giant.reviews.create!(title: "Fair.", rating: 3, body: "Not thrilled or upset. Was as expected for price.")

    end

    it 'I can make a new Review' do
      visit "/items/#{@giant.id}"

      click_link 'New Review'

      expect(current_path).to eq("/items/#{@giant.id}/reviews/new")

      fill_in 'Title', with: "WHOA A GIANT!"
      fill_in 'Rating', with: "4"
      fill_in 'Body', with: "I didn't think it was actually for realsies."

      click_button 'Submit Review'

      expect(current_path).to eq("/items/#{@giant.id}/")


      expect(page).to have_content("WHOA A GIANT!")
      expect(page).to have_content("4/5")
      expect(page).to have_content("I didn't think it was actually for realsies.")


      click_link 'New Review'

      expect(current_path).to eq("/items/#{@giant.id}/reviews/new")

      fill_in 'Title', with: "Pretty!"
      fill_in 'Body', with: "I didn't think.  Now I'm stuck with it."

      click_button 'Submit Review'

      expect(current_path).to eq("/items/#{@giant.id}/")

      expect(page).to have_content("Review could not be created, please try again.")

      fill_in 'Title', with: "Pretty!"
      fill_in 'Rating', with: 4
      fill_in 'Body', with: "I didn't think.  Now I'm stuck with it."

      click_button 'Submit Review'

      expect(current_path).to eq("/items/#{@giant.id}/")

      expect(page).to have_content("Review Created!")

      expect(page).to have_content("Pretty!")
      expect(page).to have_content("4/5")
      expect(page).to have_content("I didn't think. Now I'm stuck with it.")



      end







    end

  end


# As a visitor,
# When I visit an item's show page
# I see a link to add a new review for this item.
# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
# - a review title
# - a numeric rating that can only be a number from 1 to 5
# - some text for the review itself
# When the form is submitted, I should return to that item's
# show page and I should see my review text.
