class OrdersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @items = cart.items
    @order = Order.find(params[:id])
  end

  def new
    @items = cart.items
  end

  def create
    order = Order.create(order_params)
    if order.id.nil?
      flash[:alert] = "Please fill in all fields."
      redirect_to orders_new_path
    else
      cart.items.each do |item|
        order.order_items.create!(
          quantity: cart.item_count(item.id),
          price: item.price,
          item_id: item.id
        )
      end
    redirect_to "/orders/#{order.id}"
    end
  end

  private
  def order_params
    params.permit(:name, :address, :city, :state, :zipcode)
  end
end
