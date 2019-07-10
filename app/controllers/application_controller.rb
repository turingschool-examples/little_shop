class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :cart

  private

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def flash_message
    local_params.each do |key,value|
      if value == ''
        flash.now[:notice] = "Missing #{key}!"
        break
      end
    end
  end

  def set_items
    @items ||= cart.items
  end

  def set_item
    @item ||= Item.find(params[:item_id])
  end

  def set_merchant
    @merchant ||= Merchant.find(params[:merchant_id])
  end
end
