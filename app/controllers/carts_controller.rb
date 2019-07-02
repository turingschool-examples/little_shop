class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    quantity = cart.count_of(item.id)
    flash[:success] = "You now have #{pluralize(quantity, item.name)} in your cart."
    redirect_to items_path
  end

  def index
    
  end
end
