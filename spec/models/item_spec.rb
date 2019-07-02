require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
    it {should belong_to :merchant}
    it {should have_many(:item_orders)}
    it {should have_many(:orders).through(:item_orders)}
  end
end
