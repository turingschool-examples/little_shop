class OrdersController < ApplicationController

  def new
    @items = cart.contents.map do |item_id, quanitity|
      Item.find(item_id)
    end
  end
end
