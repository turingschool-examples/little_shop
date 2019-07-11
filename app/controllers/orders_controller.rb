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
    @order = Order.new(local_params)
    if @order.save
      @order.add_items(@items)
      session[:cart] = {}
      flash[:success] = rand(9999999999).to_s
      redirect_to(order_path(@order))
    else
      flash_message
      render :new
    end
  end

  private

  def local_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def set_order
    @order ||= Order.find(params[:id])
  end
end
