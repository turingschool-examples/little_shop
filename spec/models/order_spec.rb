require 'rails_helper'

RSpec.describe Order do
  describe 'Relationships' do
    it { should have_many :order_items }
    it { should have_many(:items).through(:order_items) }
  end

  describe "instance methods" do
    it '.grand_total' do
      
    end
  end
end
