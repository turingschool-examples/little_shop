require 'rails_helper'

RSpec.describe OrderItem do
  describe 'Relationships' do
    it { should belong_to :order }
    it { should belong_to :item }
  end

  describe 'instance methods' do
    it '.subtotal' do
      
    end
  end
end
