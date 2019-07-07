class OrdersController < ApplicationController
  before_action :set_order, only: [:show]
  before_action :set_items, only: [:new, :create]

  def show
    @items = @order.items
    @order_items = @order.order_items
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.save
    @order.add_items(@items)
    redirect_to(order_path(@order))
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def set_order
    @order ||= Order.find(params[:id])
  end

  def set_items
    @items ||= cart.items
  end
end
