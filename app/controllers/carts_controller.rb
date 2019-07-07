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

  def add_one
     item = Item.find(params[:item_id])
     @cart = Cart.new(session[:cart])
     @cart.add_item(item.id)
     session[:cart] = @cart.contents
     quantity = @cart.count_of(item.id)
     redirect_to '/cart'
  end

  def remove_one
     item = Item.find(params[:item_id])
     @cart = Cart.new(session[:cart])
     @cart.remove_item(item.id)
     session[:cart] = @cart.contents
     quantity = @cart.count_of(item.id)
     redirect_to '/cart'
  end

  def index
     @contents = session[:cart]
  end

  def destroy
    reset_session
    session[:cart] = Hash.new(0)

    @contents = session[:cart]
    flash[:emptied] = "Your cart has been emptied."
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])

    redirect_to '/cart'
  end


end
