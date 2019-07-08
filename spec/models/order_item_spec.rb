require 'rails_helper'

RSpec.describe OrderItem do
  describe 'Relationships' do
    it { should belong_to :order }
    it { should belong_to :item }
  end
end
