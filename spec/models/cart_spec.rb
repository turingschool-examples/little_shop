require 'rails_helper'

RSpec.describe Cart do
  describe 'instance methods' do
    describe '#contents' do
      it 'should return an empty hash when the contents are nil' do
        cart = Cart.new(nil)
        expect(cart.contents).to eq({})
      end
      it 'should return hash when contents exist' do
        cart = Cart.new({"12" => 2, "112" => 1})
        expect(cart.contents).to eq ({"12" => 2, "112" => 1})
      end
      describe '#add_item' do
        it 'adds items' do
          cart = Cart.new(nil)
          cart.add_item(1)
          cart.add_item(2)
          cart.add_item(2)
          cart.add_item(1)
          cart.add_item(3)

          expected = {
            "1" => 2,
            "2" => 2,
            "3" => 1
          }

          expect(cart.contents).to eq(expected)
        end
      end
    end
  end
end
