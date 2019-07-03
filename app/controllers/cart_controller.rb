class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def add_item
    item = Item.find(params[:item_id]) #ask instructors about this!!!
    cart = Cart.new(session[:cart])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:success] = "#{item.name} has been added to your cart."
    redirect_to items_path
  end
end
