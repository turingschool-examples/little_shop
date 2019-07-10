class MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :edit, :update, :destroy]

  def index
    @merchants = Merchant.all
  end

  def show
    @top_3_items = @merchant.top_three_items
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.zip.to_s.length != 5 || @merchant.zip.to_s != @merchant.zip.to_i.to_s
      flash[:notice] = "Merchant not created! Bad zip code."
      render :new
    else
      if @merchant.save
        redirect_to merchants_path
      else
        flash[:notice] = "Merchant not created! Missing information."
        render :new
      end
    end
  end

  def edit
  end

  def update
    @merchant.update(merchant_params)
    redirect_to merchant_path(@merchant)
  end

  def destroy
    if @merchant.has_items_in_orders?
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
