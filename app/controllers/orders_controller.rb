class OrdersController < ApplicationController
  def new
    @items = []
    @grand_total = 0
    cart = Cart.new(session[:cart])
    cart.contents.each do |item_id, quantity|
      @item = Item.find(item_id)
      order_item = OrderItem.new(item: @item, price: @item.price, quantity: cart.contents[item_id.to_s])
      @items << order_item
      @grand_total += order_item.subtotal
    end
    @items
  end

  def create
    order = Order.new(order_params)
    cart = Cart.new(session[:cart])
    if order.save
      cart.contents.each do |item_id, quantity|
        @item = Item.find(item_id)
        order_item = OrderItem.create(item: @item, price: @item.price, quantity: cart.contents[item_id.to_s], order: order)
      end
    reset_session
    redirect_to order_path(order)
    else
      flash[:error] = "The form must be completed to create an order."
      redirect_to new_order_path
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
