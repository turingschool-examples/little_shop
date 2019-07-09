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
    # create order from form
    cart = Cart.new(session[:cart])
    cart.contents.each do |item_id, quantity|
      @item = Item.find(item_id)
      # pass in newly created order_id
      order_item = OrderItem.new(item: @item, price: @item.price, quantity: cart.contents[item_id.to_s])

    end
  end
end
