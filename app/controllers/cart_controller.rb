class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @items = Item.find(cart.item_ids)
    if cart.contents == Hash.new(0)
      flash[:notice] = "Get to shoppin'!"
    end
  end

  def add_item
    item = Item.find(params[:item_id])
    # cart = Cart.new(session[:cart])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:success] = "#{item.name} has been added to your cart."
    redirect_to items_path
  end

  def remove_item
    item = Item.find(params[:item_id])
    cart.remove_item(item.id)
    session[:cart] = cart.contents
    flash[:success] = "#{item.name} has been removed from your cart."
    redirect_to "/cart"
  end

  def increment
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:success] = "You added +1 of #{item.name} in your cart."
    redirect_to "/cart"
  end

  def decrement
    item = Item.find(params[:item_id])
    cart.decrement(item.id)
    session[:cart] = cart.contents
    flash[:success] = "You removed 1 #{item.name} from your cart."
    redirect_to "/cart"
  end

  def destroy
    session.delete(:cart)
    redirect_to "/cart"
  end
end
