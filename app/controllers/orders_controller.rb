class OrdersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @items = cart.contents.map do |item_id, quanitity|
      Item.find(item_id)
    end
    @order = Order.find(params[:id])
  end

  def new
    @items = cart.contents.map do |item_id, quanitity|
      Item.find(item_id)
    end
  end

  def create
    order = Order.create(order_params)
    if order.id.nil?
      flash[:alert] = "Please fill in all fields."
      redirect_to orders_new_path
    else
      redirect_to "/orders/#{order.id}"
    end
  end

  private
  def order_params
    params.permit(:name, :address, :city, :state, :zipcode)
  end
end
