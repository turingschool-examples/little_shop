class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper



  def create
     item = Item.find(params[:item_id])
     @cart = Cart.new(session[:cart])
     @cart.add_item(item.id)
     session[:cart] = @cart.contents
     quantity = @cart.count_of(item.id)
     flash[:notice] = "#{item.name} has been added your cart."
     redirect_to '/items'
  end


end
