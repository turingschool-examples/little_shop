require 'rails_helper'

RSpec.describe 'Delete Review ' do
  describe 'When I visit an item show page' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @review_1 = @ogre.reviews.create!(title: 'Amazing!', content: 'The best Ogre I ever saw!', rating: 5)
      visit item_path(@ogre)
    end

    it "I can delete a review" do
      expect(page).to have_link("Delete Review")

      expect(page).to have_content('Title: Amazing!')
      expect(page).to have_content('The best Ogre I ever saw!')
      expect(page).to have_content('Rating: 5')

      click_link("Delete Review")

      expect(current_path).to eq(item_path(@ogre))

      expect(page).to_not have_content('Title: Amazing!')
      expect(page).to_not have_content('The best Ogre I ever saw!')
      expect(page).to_not have_content('Rating: 5')
    end
  end
end
