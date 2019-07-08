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
      @review4 = @giant.reviews.create!(title: "Pretty Good.", rating: 4, body: "Good Giant, wish it has come in the mail a bit earlier. It was so hungry when I opened it.")

    end

    it 'I can make a new Review' do
      visit "/items/#{@giant.id}"

      click_link 'New Review'

      expect(current_path).to eq("/item/#{@giant.id}/review/new")





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
