class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  # before_action :set_item, only: [:add_item, :remove_item]

  def add_item
    item = Item.find(params[:item_id])
    if cart.has_inventory?(item)
      cart.add_item(item.id)
      session[:cart] = cart.contents
      flash[:success] = "You now have #{pluralize(cart.count_of(item.id), item.name)} in your cart."
    else
      flash[:error] = "There is no more stock of #{item.name} available."
    end
    redirect_to items_path
  end

  def remove_item
    item = Item.find(params[:item_id])
    cart.remove_item(item.id)
    session[:cart] = cart.contents
    redirect_to cart_path
  end

  def incr_qty
    item = Item.find(params[:item_id])
    if cart.has_inventory?(item)
      cart.add_item(item.id)
      session[:cart] = cart.contents
    else
      flash[:error] = "There is no more stock of #{item.name} available."
    end
    redirect_to cart_path
  end

  def decr_qty
    item = Item.find(params[:item_id])
    cart.minus_item(item.id)
    session[:cart] = cart.contents
    redirect_to cart_path
  end

  def index
    @items = cart.items
  end

  def destroy
    session[:cart] = {}
    redirect_to cart_path
  end

  # private
  #
  # def set_item
  #   item = Item.find(params[:item_id])
  # end
end
