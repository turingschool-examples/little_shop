class OrdersController < ApplicationController
  before_action :set_order, only: [:show]
  
  def show
  end

  def new
    @order = Order.new
    @items = cart.items
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to(order_path(@order))
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def set_order
    @order ||= Order.find(params[:id])
  end
end
