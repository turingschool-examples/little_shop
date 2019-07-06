class OrderController < ApplicationController

  def new
    @contents = session[:cart]
  end

  def create
    
  end

end
