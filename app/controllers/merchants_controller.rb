class MerchantsController < ApplicationController
  before_action :get_merchant, only: [:show, :edit, :update, :destroy]

  def index
    @merchants = Merchant.all
  end

  def show
  end

  def new
  end

  def create
    merchant = Merchant.create(merchant_params)
    if merchant.id.nil?
      flash[:alert] = merchant.errors.full_messages.to_sentence
      render :new
    else
      redirect_to merchants_path
    end
  end

  def edit
  end

  def update
    @merchant.update(merchant_params)
    if merchant_params.values.any? {|value| value.empty?}
      flash[:alert] = @merchant.errors.full_messages.to_sentence
      render :edit
    else
      redirect_to merchant_path(@merchant)
    end
  end

  def destroy
    if @merchant.merchant_orders.include?(params[:id])
      flash[:alert] = "This merchant has pending orders, cannot be deleted."
      redirect_to merchant_path(@merchant)
    else
      Merchant.destroy(params[:id])
      redirect_to merchants_path
    end
  end

  private

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def get_merchant
    @merchant = Merchant.find(params[:id])
  end
end
