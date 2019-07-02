class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  # before_action :set_item, only: [:add_item, :delete_item]

  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:success] = "You now have #{pluralize(cart.count_of(item.id), item.name)} in your cart."
    redirect_to items_path
  end

  def remove_item
    item = Item.find(params[:item_id])
    cart.remove_item(item.id)
    session[:cart] = cart.contents
    redirect_to cart_path
  end

  def index
    @items = cart.items
  end

  def destroy
    session[:cart] = Cart.new(nil).contents
    redirect_to cart_path
  end

  # private
  #
  # def set_item
  #   item = Item.find(params[:item_id])
  # end
end
