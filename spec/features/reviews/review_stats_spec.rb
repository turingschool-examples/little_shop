require 'rails_helper'

RSpec.describe 'Review Statistics' do
  describe 'As a visitor'do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @review_1 = @ogre.reviews.create!(title: 'poop', rating: 1, content: 'Smells like poop!')
      @review_2 = @ogre.reviews.create!(title: 'Awesome!!!', rating: 5, content: 'These things are Awesome! Get one!!! ')
      @review_3 = @ogre.reviews.create!(title: 'WTF', rating: 2, content: "He's cute, but rreally, why?!!")
      @review_4 = @ogre.reviews.create!(title: 'Does Not Do What It Is Supposed To', rating: 3, content: "Doesn't work!")
      @review_5 = @ogre.reviews.create!(title: 'Cute', rating: 2, content: 'It was delivered in a princess outfit. How cute')
      @review_6 = @ogre.reviews.create!(title: 'Looks Good', rating: 5, content: 'This thing looks amazing')
      @review_7 = @ogre.reviews.create!(title: 'Wish It Had More Muscles', rating: 4, content: "Seriously Sejin's muscles are bigger than this thing!")
    end

    it "When I visit an item's show page I see statistics about reviews including/n
      -top three reviews for this item (title and rating only)/n
      -the bottom three reviews for this item (title and rating only)/n
      -the average rating for all reviews for this item." do

      visit item_path(@ogre) 

      within ".best_review" do
        expect(page).to have_content("Best Reviews:")
        expect(page).to have_content(@review_6.rating)
        expect(page).to have_content(@review_6.title)
        expect(page).to have_content(@review_2.rating)
        expect(page).to have_content(@review_2.title)
        expect(page).to have_content(@review_7.rating)
        expect(page).to have_content(@review_7.title)
      end

      within ".worst_review" do
        expect(page).to have_content("Worst Reviews:")
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_3.rating)
        expect(page).to have_content(@review_3.title)
        expect(page).to have_content(@review_5.rating)
        expect(page).to have_content(@review_5.title)
      end

      within ".average_rating" do
        expect(page).to have_content(@ogre.average_rating)
      end
    end
  end
end
