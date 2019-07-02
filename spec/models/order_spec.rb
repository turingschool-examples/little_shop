require 'rails_helper'

RSpec.describe Order do
  describe 'Relationships' do
    it {should have_many(:item_orders)}
    it {should have_many(:items).through(:item_orders)}
  end
end
