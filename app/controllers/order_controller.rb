class OrderController < ApplicationController

  def new
    @contents = session[:cart]
  end

  def create
    @order = Order.create(order_params)
    @contents = session[:cart]
    @contents.each do |item, quantity|
      ItemOrder.create(order_id: @order.id, item_id: item, quantity: quantity, price: Item.find(item).price)
    end
    redirect_to "/order/#{@order.id}"
  end

  def show
    @order = Order.find(params[:order_id])
    @item_orders = @order.item_orders
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
