require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should belong_to :item}
  end
end
