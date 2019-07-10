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


end
