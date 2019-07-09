require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
    it {should belong_to :merchant}
    it {should have_many :order_items}
    it {should have_many :orders}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :price}
    it {should validate_presence_of :image}
    it {should validate_presence_of :inventory}
  end

  describe 'Methods' do
    it 'returns average rating and sorted reviews' do
      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      review_1 = ogre.reviews.create!(title: 'Amazing!', content: 'The best Ogre I ever saw!', rating: 2)
      review_2 = ogre.reviews.create!(title: 'Better than amazing!', content: 'The best Giant anyone ever saw!', rating: 3)
      review_3 = ogre.reviews.create!(title: 'Better than amazing!', content: 'The best Ogre anyone ever saw!', rating: 5)
      review_4 = ogre.reviews.create!(title: 'Better than amazing!', content: 'The best Ogre anyone ever saw!', rating: 4)

      expect(ogre.average_rating).to eq(3.5)
      expect(ogre.sorted_reviews).to eq([[review_1,review_2,review_4],[review_2,review_4,review_3]])
    end
  end
end
