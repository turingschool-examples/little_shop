require "rails_helper"

RSpec.describe "Edit a Review", type: :feature do
  describe "As a visitor" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)

      @review_1 = @hippo.reviews.create!(title: "Title 1", content: "Description of Review 1", rating: 1)
      @review_2 = @hippo.reviews.create!(title: "Title 2", content: "Description of Review 2", rating: 2)
      @review_3 = @hippo.reviews.create!(title: "Title 3", content: "Description of Review 3", rating: 3)
    end

    describe "When I visit an item's show page" do
      it "I see a link to edit the review next to each review" do
        visit "/items/#{@hippo.id}"

        within "#review-#{@review_1.id}" do
          expect(page).to have_link("Edit Review")
        end

        within "#review-#{@review_2.id}" do
          expect(page).to have_link("Edit Review")
        end

        within "#review-#{@review_3.id}" do
          expect(page).to have_link("Edit Review")
        end
      end

      it "When I click the 'Edit Review' link I see a new page that has a form to edit title, rating, text" do
        visit "/items/#{@hippo.id}"

        within "#review-#{@review_1.id}" do
          click_on "Edit Review"
        end

        expect(current_path).to eq("/items/#{@hippo.id}/reviews/#{@review_1.id}/edit")
        expect(page).to have_content("Title")
        expect(page).to have_content("Description")
        expect(page).to have_content("Rating")

        fill_in "Title", with: "The Biggest Baddest Giant"
        fill_in "Description", with: "Out of all the giants I've ever owned, this one is by far the biggest and badest!"
        fill_in "Rating", with: 5

        click_on "Create Review"

        expect(current_path).to eq("/items/#{@hippo.id}")
        expect(page).to have_content("The Biggest Baddest Giant")
        expect(page).to have_content("Out of all the giants I've ever owned, this one is by far the biggest and badest!")
        expect(page).to have_content(5)
      end
    end
  end
end
