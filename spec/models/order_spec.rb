require 'rails_helper'

RSpec.describe Order do
  describe 'Relationships' do
    it {should have_many(:items).through(:order_items)}
  end
end
