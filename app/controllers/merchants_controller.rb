class MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :edit, :update, :destroy]

  def index
    @merchants = Merchant.all
  end

  def show
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.zip.to_s.length != 5 || @merchant.zip.to_s != @merchant.zip.to_i.to_s
      flash[:notice] = "Merchant not created! Bad zip code."
      render :new
    elsif @merchant.name == nil || @merchant.name.length < 1
      flash[:notice] = "Merchant must have a name. Please input all information."
      render :new
    elsif @merchant.address == nil || @merchant.address.to_s.length < 1
      flash[:notice] = "Merchant must have an address. Please input all information."
      render :new
    elsif @merchant.city == nil || @merchant.city.length < 1
      flash[:notice] = "Merchant must have a city. Please input all information."
      render :new
    elsif @merchant.state == nil || @merchant.state.length < 1
      flash[:notice] = "Merchant must have a state. Please input all information."
      render :new
    else
      @merchant.save
      redirect_to merchants_path
    end
  end

  def edit
  end

  def update
    @merchant.update(merchant_params)
    redirect_to merchant_path(@merchant)
  end

  def destroy
    # if I click on the delete button, I see a flash message indicating that the merchant can not be deleted.
    # singular if statement?
    if @order_items.items.merchants.includes?(@merchant)
      flash[:notice] = "You cannot delete this merchant."
      render :new
    else
      @merchant.destroy
      redirect_to merchants_path
    end
  end

  private

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def set_merchant
    @merchant ||= Merchant.find(params[:id])
  end
end
