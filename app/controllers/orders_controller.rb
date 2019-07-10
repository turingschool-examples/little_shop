class OrdersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @order = Order.find(params[:id])
    @items =  @order.items
  end

  def new
    @items = cart.items
  end

  def create
    order = Order.create(order_params)
    if order.id.nil?
      flash[:alert] = "Please fill in all fields."
      redirect_to new_order_path
    else
      cart.add_cart_to_order_items(order)
      session[:cart] = {}
      redirect_to order_path(order)
    end
  end

  private
  def order_params
    params.permit(:name, :address, :city, :state, :zipcode)
  end
end
