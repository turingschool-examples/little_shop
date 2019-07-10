class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @items = cart.items
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    cart.contents.each do |key, qty|
      item = Item.find(key.to_i)
      OrderItem.create(order_id: @order, item_id: item, count: qty, amount: item.price)
    end
    if @order.name == nil
      flash[:error] = "Shipping Information is required in all fields. Please input a name."
      render :new
    elsif @order.address == nil
      flash[:notice] = "Shipping Information requires an address. Please input an address."
      render :new
    elsif @order.city == nil
      flash[:notice] = "Shipping Information requires a city. Please input a city."
      render :new
    elsif @order.state == nil
      flash[:notice] = "Shipping Information requires a state. Please input a state."
      render :new
    elsif @order.zip == nil
      flash[:notice] = "Shipping Information requires a valid zipcode. Please input a zipcode."
      render :new
    else
      @order.save
      session.delete(:cart)
      redirect_to order_path
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
