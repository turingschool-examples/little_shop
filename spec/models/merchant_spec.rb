require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "methods" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @megan.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @elephant = @megan.items.create!(name: 'Elephant', description: "I'm an Elephant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @order_1 = Order.create!(name: 'Bob', address: '123', city: 'Denver', state: 'CA', zip: '80222')
      @order_2 = Order.create!(name: 'Bob', address: '123', city: 'New York', state: 'CA', zip: '80222')
      @order_3 = Order.create!(name: 'Bob', address: '123', city: 'Albany', state: 'CA', zip: '80222')
    end

    it 'has_items_in_orders' do
      expect(@megan.has_items_in_orders?).to eq(false)
      expect(@brian.has_items_in_orders?).to eq(false)

      @order_1.add_items({@ogre => 2, @elephant => 1})

      expect(@megan.has_items_in_orders?).to eq(true)
      expect(@brian.has_items_in_orders?).to eq(false)
    end

    it 'returns top three items' do
      review_1 = @ogre.reviews.create!(title: 'Amazing!', content: 'The best Ogre I ever saw!', rating: 2)
      review_2 = @giant.reviews.create!(title: 'Better than amazing!', content: 'The best Giant anyone ever saw!', rating: 3)
      review_3 = @hippo.reviews.create!(title: 'Better than amazing!', content: 'The best Ogre anyone ever saw!', rating: 5)
      review_4 = @elephant.reviews.create!(title: 'Better than amazing!', content: 'The best Ogre anyone ever saw!', rating: 4)
      @order_1.add_items({@ogre => 2, @elephant => 1})
      @order_2.add_items({@ogre => 2, @elephant => 1})
      @order_3.add_items({@ogre => 2, @elephant => 1})

      expect(@megan.top_three_items).to eq([@hippo, @elephant, @giant])
      expect(@megan.cities_served).to eq(['Albany', 'Denver', 'New York'])
    end
  end
end
