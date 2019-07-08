require 'rails_helper'

RSpec.describe OrderItem do
  describe 'Relationships' do
    it { should belong_to :orders }
    it { should belong_to :items } 
  end
end
