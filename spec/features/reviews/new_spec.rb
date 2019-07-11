require 'rails_helper'

RSpec.describe 'New Review' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      visit item_path(@ogre)
    end

    it 'I can create a review for an item' do
      title = 'Neat!'
      content = "It's an Ogre!"
      rating = '5'

      visit item_path(@ogre)

      click_link 'Write Review'

      expect(current_path).to eq(new_review_path(@ogre))

      fill_in :title, with: title
      fill_in :content, with: content
      select(rating, from: :rating)

      click_button 'Create Review'

      expect(current_path).to eq(item_path(@ogre))
      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content(rating)
      expect(page).to have_content('Average Rating: 5.0')
    end

    it 'I see a flash message when info is missing' do
      title = 'Neat!'
      content = "It's an Ogre!"
      rating = '5'
      visit item_path(@ogre)
      click_link 'Write Review'

      expect(current_path).to eq(new_review_path(@ogre))

      click_button 'Create Review'

      expect(page).to have_content('Missing title!')

      fill_in :title, with: title
      click_button 'Create Review'

      expect(current_path).to eq(review_path(@ogre))
      expect(page).to have_content('Missing content!')
      expect(find_field(:title).value).to eq(title)

      fill_in :content, with: content
      click_button 'Create Review'

      expect(current_path).to eq(review_path(@ogre))
      expect(page).to have_content('Missing rating!')
      expect(find_field(:title).value).to eq(title)
      expect(find_field(:content).value).to eq(content)

      select(rating, from: :rating)
      click_button 'Create Review'

      expect(current_path).to eq(item_path(@ogre))
      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content(rating)
      expect(page).to have_content('Average Rating: 5.0')
    end
  end
end
