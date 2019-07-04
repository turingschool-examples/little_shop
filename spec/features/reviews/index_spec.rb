require 'rails_helper'

RSpec.describe 'Reviews on item show page' do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @review_1 = @ogre.reviews.create!(title: 'Amazing!', content: 'The best Ogre I ever saw!', rating: 5)
    @review_2 = @ogre.reviews.create!(title: 'Better than amazing!', content: 'The best Ogre anyone ever saw!', rating: 5)
    visit item_path(@ogre)
  end

  describe 'I visit an item show page' do
    it 'I see a list of reviews for the item' do
      within "#review-#{@review_1.id}" do
        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_1.content)
        expect(page).to have_content(@review_1.rating)
      end

      within "#review-#{@review_2.id}" do
        expect(page).to have_content(@review_2.title)
        expect(page).to have_content(@review_2.content)
        expect(page).to have_content(@review_2.rating)
      end
    end

    it 'I see a link to add a review' do
      expect(page).to have_link('Write Review')

      click_link('Write Review')

      expect(current_path).to eq(new_review_path)
    end
  end
end
