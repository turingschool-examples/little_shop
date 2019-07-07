class OrdersController < ApplicationController
  def new
    @order = Order.new
    @items = cart.items
  end

  def create

  end
end
