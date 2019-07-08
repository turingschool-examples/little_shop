# frozen_string_literal: true

class OrdersController < ApplicationController
  def new
    @order = Order.new
    @items = Item.find(cart.item_and_quantity)
    # binding.pry
  end

  def create
    @items = Item.find(cart.item_and_quantity)
    @order = Order.create(order_params)
    cart.contents.each do |item, quantity|
      OrderItem.create!(price: Item.find(item).price, quantity: quantity, order: @order, item: item)
    end
    redirect_to "/orders/#{@order.id}"
  end

  def show
    @items = Item.find(cart.item_and_quantity)
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
