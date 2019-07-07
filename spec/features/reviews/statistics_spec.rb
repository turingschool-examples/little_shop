require 'rails_helper'

RSpec.describe 'Review Statistics' do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @review_1 = @ogre.reviews.create!(title: 'Amazing!', content: 'The best Ogre I ever saw!', rating: 5)
    @review_2 = @ogre.reviews.create!(title: 'Better than amazing!', content: 'The best Ogre anyone ever saw!', rating: 4)
    @review_3 = @ogre.reviews.create!(title: 'Better than amazing!', content: 'The best Ogre anyone ever saw!', rating: 3)
    @review_4 = @ogre.reviews.create!(title: 'Better than amazing!', content: 'The best Ogre anyone ever saw!', rating: 2)
    visit item_path(@ogre)
  end

  describe 'I visit an item show page' do
    it 'I see an average of all the reviews' do
      within '#review-stats' do
        expect(page).to have_content('Average Rating: 3.5')
      end

      within "#top-three" do
        expect(page.all('p')[0]).to have_content(@review_1.title)
        expect(page.all('p')[0]).to have_content(@review_1.rating)
        expect(page.all('p')[1]).to have_content(@review_2.title)
        expect(page.all('p')[1]).to have_content(@review_2.rating)
        expect(page.all('p')[2]).to have_content(@review_3.title)
        expect(page.all('p')[2]).to have_content(@review_3.rating)
      end

      within "#bottom-three" do
        expect(page.all('p')[0]).to have_content(@review_2.title)
        expect(page.all('p')[0]).to have_content(@review_2.rating)
        expect(page.all('p')[1]).to have_content(@review_3.title)
        expect(page.all('p')[1]).to have_content(@review_3.rating)
        expect(page.all('p')[2]).to have_content(@review_4.title)
        expect(page.all('p')[2]).to have_content(@review_4.rating)
      end
    end
  end
end
