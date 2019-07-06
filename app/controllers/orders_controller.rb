class OrdersController < ApplicationController
  def new
    @order = Order.new
    @items = Item.find(cart.item_ids)
  end

  def create
    order = Order.new(order_params)
    if order.save
      flash[:success] = "Your order has been created."
      redirect_to "/orders/#{order.id}"
    else
      flash[:error] = "Order not created. You are missing required field(s)."
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @items = Item.find(cart.item_ids)
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
