class OrdersController < ApplicationController
  before_action :set_order, only: [:show]
  before_action :set_items, only: [:new, :create]

  def show
    @items = @order.items
    @order_items = @order.order_items
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @order.add_items(@items)
      session[:cart] = {}
      redirect_to(order_path(@order))
    else
      case
      when order_params[:name] == ''
        flash.now[:notice] = 'Missing name!'
      when order_params[:address] == ''
        flash.now[:notice] = 'Missing address!'
      when order_params[:city] == ''
        flash.now[:notice] = 'Missing city!'
      when order_params[:state] == ''
        flash.now[:notice] = 'Missing state!'
      when order_params[:zip] == ''
        flash.now[:notice] = 'Missing zip!'
      end
      render :new
    end
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def set_order
    @order ||= Order.find(params[:id])
  end

  def set_items
    @items ||= cart.items
  end
end
