class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def add_item
    item = Item.find(params[:item_id])
    # cart = Cart.new(session[:cart])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:success] = "#{item.name} has been added to your cart."
    redirect_to items_path
  end

  def index
    @items = Item.find(cart.item_ids)
    if cart.contents == Hash.new(0)
      flash[:notice] = "Get to shoppin'!"
    end
  end

  def destroy
    session.delete(:cart)
    redirect_to "/cart"
  end
end
