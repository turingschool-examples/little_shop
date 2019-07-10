require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}
  end

  describe "Merchant Methods" do
    before(:each) do


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

end
