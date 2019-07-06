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

    redirect_to "/orders/#{order.id}"
  end


  private
  def order_params
    params.permit(:name, :address, :city, :state, :zipcode)
  end

end
