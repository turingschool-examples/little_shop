# frozen_string_literal: true

class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    # quantity = cart.count_of(item.id)
    flash[:notice] = "You now have #{session[:cart][item.id.to_s]} #{item.name} in your cart."
    redirect_to items_path
  end

  def show
    @items = Item.find(cart.item_and_quantity)
  end

  def destroy
    cart.contents.clear
    redirect_to cart_path
  end

  def remove_item
    item = Item.find(params[:item_id])
    cart.contents.delete(item.id.to_s)
    redirect_to cart_path
  end

  def update
    # binding.pry
    item = Item.find(params[:item_id])

    if cart.contents[item.id.to_s] >= item.inventory
      flash[:notice] = 'Order quantity exceeds inventory'
    else
      cart.contents[item.id.to_s] += 1
    end

    redirect_to cart_path
  end

  private

  # def set_cart
  #   @cart = Item.find(params[:id])
  # end
#
#   def cart_params
#     params.require(:cart).permit(:)
#   end
# end
end
