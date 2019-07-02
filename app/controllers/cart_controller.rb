class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def add_item
    # binding.pry
    item = Item.find(params[:item_id])
    cart = Cart.new(session[:cart])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:notice] = "#{item.name} has been added to your cart."
    # flash[:notice] = "You now have #{pluralize(cart.item_count(item.id), item.name)}"
    redirect_to items_path
  end
end
