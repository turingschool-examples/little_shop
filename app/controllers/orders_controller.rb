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
    order = Order.create(order_params)
    cart = Cart.new(session[:cart])
    cart.contents.each do |item_id, quantity|
      @item = Item.find(item_id)
      order_item = OrderItem.new(item: @item, price: @item.price, quantity: cart.contents[item_id.to_s], order: order)
      redirect_to order_path(order)
    end
  end

  def show
    @items = []
    @grand_total = 0
    @order = Order.find(params[:id])
    cart = Cart.new(session[:cart])
    cart.contents.each do |item_id, quantity|
      @item = Item.find(item_id)
      order_item = OrderItem.new(item: @item, price: @item.price, quantity: cart.contents[item_id.to_s], order: @order)
      @items << order_item
      @grand_total += order_item.subtotal
    end
    @items
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
