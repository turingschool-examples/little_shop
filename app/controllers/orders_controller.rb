class OrdersController < ApplicationController
  def new
    @order = Order.new
    @items = Item.find(cart.item_ids)
  end

  def create
    order = Order.new(order_params)

    cart.contents.each do |item_id, quantity|
      OrderItem.create(order: order, item_id: item_id, quantity: quantity, price_per_item: Item.find(item_id).price)
    end

    if order.save
      session.delete(:cart)
      flash[:success] = "Your order has been created."
      redirect_to "/orders/#{order.id}"
    else
      flash[:error] = "Order not created. You are missing required field(s)."
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
