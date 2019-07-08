class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @items = cart.items
    #should order items be created here right when there is a new instance of order?
    @order = Order.new
  end

end
