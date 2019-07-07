class OrdersController < ApplicationController
  def new
    @items = Item.find(cart.item_and_quantity)
    # binding.pry
  end
end
