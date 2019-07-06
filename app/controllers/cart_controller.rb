class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def add_item
    item = Item.find(params[:item_id])
    cart = Cart.new(session[:cart])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:notice] = "You now have #{pluralize(cart.item_count(item.id), item.name)} in your cart."
    redirect_to items_path
  end

  def show
    # cart = Cart.new(session[:cart])
    @items = cart.contents.map do |item_id, quanitity|
      Item.find(item_id)
    end
  end

  def destroy
    session[:cart] = {}
    redirect_to cart_path
  end

  def remove_item
    cart.remove_item(params[:item_id])
    session[:cart] = cart.contents

    redirect_to cart_path
  end

  def update
    item_id = params[:item_id]

      current_quantity = session[:cart][item_id]
      new_quantity = params[current_quantity.to_s]

      if new_quantity.to_i > Item.find(item_id).inventory
        flash[:alert] = "Sorry, there is not enough in stock for this order."
        redirect_to cart_path
      elsif new_quantity.to_i <= 0
        session[:cart].delete(item_id)
        flash[:alert] = "Item has been removed from your cart."
        redirect_to cart_path
      else
        cart.update_quantity(params[:item_id], new_quantity)
        session[:cart] = cart.contents

        redirect_to cart_path
      end
  end
end
