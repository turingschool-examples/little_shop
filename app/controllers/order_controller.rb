class OrderController < ApplicationController

  def new
    @contents = session[:cart]
  end

end
