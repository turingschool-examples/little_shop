require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({'1' => 2, '2' => 3}) }

  describe '#contents' do
    it 'should return empty contents' do
      expect(Cart.new(nil).contents).to eq({})
    end

    it 'should return cart contents' do
      expect(subject.contents).to eq({'1' => 2, '2' => 3})
    end
  end

  describe "#total_count" do
    it "calculates the total number of items it holds" do
      expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_item" do
    it "adds a item to its contents" do
      subject.add_item(1)
      subject.add_item(2)

      expect(subject.contents).to eq({'1' => 3, '2' => 4})
    end
  end

  describe '#count_of' do
    it 'returns the count of this item in the cart' do
      expect(Cart.new({}).count_of(5)).to eq(0)
    end
  end
end
