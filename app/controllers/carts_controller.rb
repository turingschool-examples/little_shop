class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:success] = "You now have #{pluralize(cart.count_of(item.id), item.name)} in your cart."
    redirect_to items_path
  end

  def index
    @items = cart.items
  end
end
