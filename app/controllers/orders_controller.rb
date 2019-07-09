class OrdersController < ApplicationController
  def new
    @items = []
    cart = Cart.new(session[:cart])
    cart.contents.each do |item_id, quantity|
      @item = Item.find(item_id)
      order_item = OrderItem.new(item: @item, price: @item.price, quantity: cart.contents[item_id.to_s])
      @items << order_item
    end
    @items
  end

  def create
    # @items = []
    # create order from form

    cart = Cart.new(session[:cart])
    cart.contents.each do |item_id, quantity|
      @item = Item.find(item_id)
      # pass in newly created order_id
      order_item = OrderItem.new(item: @item, price: @item.price, quantity: cart.contents[item_id.to_s])

    end
  end
end
