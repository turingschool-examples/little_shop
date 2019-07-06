require 'rails_helper'

RSpec.describe 'Edit Review ' do
  describe 'When I visit an item show page' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @review_1 = @ogre.reviews.create!(title: 'Amazing!', content: 'The best Ogre I ever saw!', rating: 5)
      visit item_path(@ogre)
    end

    it "I can edit each review" do
      expect(page).to have_link("Edit Review")

      click_link("Edit Review")

      expect(current_path).to eq(edit_review_path(@ogre, @review_1))

      expect(find_field(:title).value).to eq('Amazing!')
      expect(find_field(:content).value).to eq('The best Ogre I ever saw!')
      expect(find_field(:rating).value).to eq('5')

      fill_in 'Title', with: 'Rawrrr!'
      fill_in 'Rating', with: 5
      fill_in 'Content', with: 'Grawwr?!'

      click_button("Update Review")

      expect(current_path).to eq(item_path(@ogre))

      expect(page).to have_content('Title: Rawrrr!')
      expect(page).to have_content('Grawwr?!')
      expect(page).to have_content('Rating: 5')
    end
  end
end
