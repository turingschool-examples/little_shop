require 'rails_helper'

RSpec.describe Item do

  describe 'Relationships' do
    it {should belong_to :merchant}
    it {should have_many :order_items}
    it {should have_many(:orders).through(:order_items)}
    it {should have_many :reviews}
  end

  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @review_1 = @ogre.reviews.create!(title: 'poop', rating: 1, content: 'Smells like poop!')
    @review_2 = @ogre.reviews.create!(title: 'Awesome!!!', rating: 5, content: 'These things are Awesome! Get one!!! ')
    @review_3 = @ogre.reviews.create!(title: 'WTF', rating: 2, content: "He's cute, but rreally, why?!!")
    @review_4 = @ogre.reviews.create!(title: 'Does Not Do What It Is Supposed To', rating: 3, content: "Doesn't work!")
    @review_5 = @ogre.reviews.create!(title: 'Cute', rating: 4, content: 'It was delivered in a princess outfit. How cute')
    @review_6 = @ogre.reviews.create!(title: 'Looks Good', rating: 5, content: 'This thing looks amazing')
    @review_7 = @ogre.reviews.create!(title: 'Wish It Had More Muscles', rating: 4, content: "Seriously Sejin's muscles are bigger than this thing!")
    @jori = Order.create!(name: "Jori", address: "12 Market St", city: "Denver", state: "CO", zipcode: "80021")
    @sejin = Order.create!(name: "Sejin", address: "12 Market St", city: "Las Vegas", state: "NV", zipcode: "80021")
    @jori.items << @ogre
    @sejin.items << [@hippo, @ogre]
  end

  describe '#best_reviews' do
    it 'returns the top three best reviews' do

      expected = [@review_2, @review_6, @review_5]

      expect(@ogre.best_reviews).to eq(expected)
    end
  end

  describe '#worst_reviews' do
    it 'returns the three worst reviews' do

      expected = [@review_1, @review_3, @review_4]

      expect(@ogre.worst_reviews).to eq(expected)
    end
  end

  describe '#average_rating' do
      it 'returns average rating as an integer' do
        expect(@ogre.average_rating.to_f.round(2)).to eq(3.43)
    end
  end

  describe '#item_orders' do
    it "should return item ids within all orders" do
      expect(@ogre.item_orders.uniq).to eq([@ogre.id, @hippo.id])
    end
  end
end
