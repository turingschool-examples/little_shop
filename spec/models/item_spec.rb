require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
    it { should belong_to :merchant }
    it { should have_many :reviews }
    it { should have_many :order_items }
    it { should have_many(:orders).through(:order_items) }
  end

  describe 'instance methods' do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
      @review_1 = @ogre.reviews.create!(title: 'Great', content: "Great", rating: 5)
      @review_2 = @ogre.reviews.create!(title: 'Good', content: "Good!", rating: 4)
      @review_3 = @ogre.reviews.create!(title: 'Great', content: "Great", rating: 5)
      @review_4 = @ogre.reviews.create!(title: 'Ogre', content: "Good!", rating: 3)
      @review_5 = @ogre.reviews.create!(title: 'Ogre', content: "Fair", rating: 1)
    end

  describe '#average_rating' do
    it 'Displays average of all ratings' do
    expect(@ogre.average_rating).to eq(3)
    end
  end

  describe '#top_reviews' do
    it 'Displays the three reviews with the highest rating' do
      expected = [@review_1, @review_3, @review_2]
      expect(@ogre.top_reviews).to eq(expected)
    end
  end

  describe '#worst_reviews' do
    it 'Displays the three ratings with the lowest rating' do
      expected = [@review_5, @review_4, @review_2]
      expect(@ogre.worst_reviews).to eq(expected)
    end
    end
 end
end
