class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # add_flash_types :alert

  helper_method :cart

  def cart
    Cart.new(session[:cart])
  end
end
