require 'rails_helper'

RSpec.describe Order do
  describe 'Relationships' do
    it {should have_many(:items).through(:order_items)}
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
  end
end
