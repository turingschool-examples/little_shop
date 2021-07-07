require "rails_helper"
RSpec.describe "Review Creation", type: :feature do
  describe "As a visitor" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    describe "When I visit an item's show page" do
      it "I see a link to add a new review for this item that takes me to a new review path." do
        visit "/items/#{@giant.id}"

        expect(page).to have_link("Add Review")
        click_on("Add Review")

        expect(current_path).to eq("/items/#{@giant.id}/reviews/new")
      end
    end

    describe "When I click the add review link, I am taken to the form" do
      it "Where I must enter review information" do
        visit "/items/#{@giant.id}"

        click_on("Add Review")

        expect(current_path).to eq("/items/#{@giant.id}/reviews/new")

        fill_in "Title", with: "My Giant"
        fill_in "Description", with: "HE IS SO HUGE"
        fill_in "Rating", with: 4

        expect(page).to have_button("Create Review")
        click_button "Create Review"

        new_review = Review.last

        expect(current_path).to eq("/items/#{@giant.id}")
        expect(page).to have_content("Title: #{new_review.title}")
        expect(page).to have_content("Description: #{new_review.content}")
        expect(page).to have_content("Rating: #{new_review.rating}")
      end
    end

    describe "When I fail to fully complete the new review form, but still try to submit the form" do
     it "I see a flash message indicating that I need to complete the form in order to submit a review" do
       visit "/items/#{@giant.id}/reviews/new"

       fill_in "Title", with: "My Giant"
       fill_in "Description", with: "HE IS SO HUGE"
       # RATING BLANK
       click_button "Create Review"

       expect(page).to have_content("Review not created; required field(s) missing!")
      end
    end
  end
end
