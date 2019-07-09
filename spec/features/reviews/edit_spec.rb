require 'rails_helper'

RSpec.describe 'Item Show Page' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @review1 = @giant.reviews.create!(title: "Damn!", rating: 5, body: "Definitely a Giant. No argument there")
      @review2 = @giant.reviews.create!(title: "Disappointed...", rating: 1, body: "Idk what I was expecting but I was disappointed.")
      @review3 = @giant.reviews.create!(title: "Fair.", rating: 3, body: "Not thrilled or upset. Was as expected for price.")
      @review4 = @giant.reviews.create!(title: "Pretty Good.", rating: 4, body: "Good Giant, wish it has come in the mail a bit earlier. It was so hungry when I opened it.")
    end

    describe "user can edit reviews" do

      it "can handle successful edit" do
        visit "/items/#{@giant.id}"

          within "#individual_review-#{@review1.id}" do
            click_on "Edit Review"
          end

          expect(current_path).to eq("/items/#{@giant.id}/reviews/#{@review1.id}/edit")

          fill_in 'Title', with: "Nice!"
          fill_in 'Rating', with: 4
          fill_in 'Body', with: "Very, Very Nice."

          click_on "Update Info"

          expect(current_path).to eq("/items/#{@giant.id}")

          expect(page).to have_content("Review Updated!")

          within "#individual_review-#{@review1.id}" do
            expect(page).to have_content("Nice!")
            expect(page).to have_content("4")
            expect(page).to have_content("Very, Very Nice.")
          end
        end
      end

      it "can handle unsucessful edit" do
        visit "/items/#{@giant.id}"

          within "#individual_review-#{@review1.id}" do
            click_on "Edit Review"
          end
          expect(current_path).to eq("/items/#{@giant.id}/reviews/#{@review1.id}/edit")

          fill_in 'Title', with: "Nice!"
          fill_in 'Rating', with: ""
          fill_in 'Body', with: "Very, Very Nice."

          click_on "Update Info"

          expect(current_path).to eq("/items/#{@giant.id}/reviews/#{@review1.id}")

          expect(page).to have_content("Review could not be updated, please fill in all fields.")

          fill_in 'Title', with: "Nice!"
          fill_in 'Rating', with: "5"
          fill_in 'Body', with: "Very, Very Nice."

          click_on "Update Info"

          expect(current_path).to eq("/items/#{@giant.id}")

          within "#individual_review-#{@review1.id}" do
            expect(page).to have_content("Nice!")
            expect(page).to have_content("5")
            expect(page).to have_content("Very, Very Nice.")
          end


      end

  end



end




# As a visitor,
# When I visit an item's show page
# I see a link to edit the review next to each review.
# When I click on this link, I am taken to an edit review path
# On this new page, I see a form that includes:
# - title
# - numeric rating
# - text of the review itself
# I can update any of these fields and submit the form.
# When the form is submitted, I should return to that item's
# show page and I should see my updated review
