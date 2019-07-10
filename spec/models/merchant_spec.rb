require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}
  end

  describe "Merchant Methods" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    end
  end

  describe "total_inventory" do
    it "Check the total inventory of a merchant in an order" do

    end
  end

  describe "ave_item_price" do
    it "Get the average item price of a merchants items in an order" do

    end
  end

  describe "cities" do
    it "Find the distinct cities of a merchants sold items" do

    end
  end

  describe "has_items_in_orders" do
    it "Check it a merchant has items in past orders." do

    end
  end

end
