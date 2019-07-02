class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    @cart = Cart.new(session[:cart])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    quantity = @cart.count_of(item.id)
    flash[:notice] = "You now have #{session[:cart][item_id_str]} #{item.name} in your cart."
    redirect_to items_path
  end
end
