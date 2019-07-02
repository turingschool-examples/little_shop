require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({'1' => 2, '2' => 3}) }

  describe '#contents' do
    it 'should return empty contents' do
      expect(Cart.new(nil).contents).to eq({})
    end

    it 'should return cart contents' do
      expect(subject.contents).to eq({'1' => 2, '2' => 3})
    end
  end

  describe "#total_count" do
    it "calculates the total number of items it holds" do
      expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_item" do
    it "adds a item to its contents" do
      subject.add_item(1)
      subject.add_item(2)

      expect(subject.contents).to eq({'1' => 3, '2' => 4})
    end
  end

  describe '#count_of' do
    it 'returns the count of this item in the cart' do
      expect(Cart.new({}).count_of(5)).to eq(0)
    end
  end

  describe 'when I visit the item show page' do
    describe 'I click the Add to Cart link' do
      it "I can add the item to the cart" do
        megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        visit "/items/#{ogre.id}"

        expect(page).to have_content("Cart: 0")
        
        click_link "Add to Cart"

        expect(page).to have_content("You now have 1 Ogre in your cart.")
        expect(page).to have_content("Cart: 1")
        expect(current_path).to eq(items_path)
      end
    end
  end
end
