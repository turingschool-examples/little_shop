require 'rails_helper'

RSpec.describe Order do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}

  end
  describe 'Relationships' do
    it { should have_many :order_items }
    it { should have_many(:items).through(:order_items) }
  end
end
