class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def add_item
    item = Item.find(params[:item_id])
    cart = Cart.new(session[:cart])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:success] = "You now have #{pluralize(cart.item_count(item.id), 'item')}: #{item.name} in your cart."
    redirect_to item_path(item.id)
  end

  def show
    @cart = Cart.new(session[:cart])
    unless @cart.contents.empty?
      @cart
    else
      flash[:alert] = "Your Cart is currently empty"
    end
  end

  def remove_item
    cart = Cart.new(session[:cart])
    @item = Item.find(params[:item_id])
    cart.remove_item(item.id)
    redirect_to "/cart"
  end

  def decrease_count
    cart = Cart.new(session[:cart])
    @=item = Item.find(params[:item_id])
    cart.decrease_count(@item.item_id)
    redirect_to "/cart"
  end

  def increase_count
  cart = Cart.new(session[:cart])
  @item = Item.find(params[:item_id])
  cart.increase_count(@item.item_id)
  redirect_to "/cart"
    end

    def destroy
    session.delete(:cart)
   redirect_to '/cart'
  end
end
