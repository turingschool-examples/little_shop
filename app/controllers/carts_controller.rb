class CartsController < ApplicationController
  def create
    # binding.pry
    item = Item.find(params[:item_id])
    flash[:notice] = "#{item.name} has been added to your cart."
    redirect_to items_path
  end
end
