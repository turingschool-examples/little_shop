class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    merchant = Merchant.create(merchant_params)
    if merchant.id.nil?
      flash[:alert] = merchant.errors.full_messages.to_sentence
      render :new
    else
      redirect_to '/merchants'
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    if merchant_params.values.any? {|value| value.empty?}
      flash[:alert] = @merchant.errors.full_messages.to_sentence
      render :edit
    else
      redirect_to "/merchants/#{@merchant.id}"
    end
  end

  def destroy
    merchant = Merchant.find(params[:id])
    if merchant.merchant_orders.include?(params[:id])
      flash[:alert] = "This merchant has pending orders, cannont be deleted."
      redirect_to "/merchants/#{merchant.id}"
    else
      Merchant.destroy(params[:id])
      redirect_to '/merchants'
    end
  end

  private

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
