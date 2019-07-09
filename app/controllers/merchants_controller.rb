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
    @merchant = Merchant.new(local_params)
    if @merchant.zip.to_s.length != 5 || @merchant.zip.to_s != @merchant.zip.to_i.to_s
      flash.now[:notice] = 'Please enter a valid zip code.'
      render :new
    else
      if @merchant.save
        redirect_to merchants_path
      else
        flash_message
        render :new
      end
    end
  end

  def edit
  end

  def update
    if local_params[:zip].to_s.length != 5 || local_params[:zip].to_s != local_params[:zip].to_i.to_s
      flash.now[:notice] = 'Please enter a valid zip code.'
      render :edit
    else
      if local_params.values.any? {|input| input == ''}
        flash_message
        render :edit
      else
        @merchant.update(local_params)
        redirect_to merchant_path(@merchant)
      end
    end
  end

  def destroy
    if @merchant.items.empty?
      @merchant.destroy
      redirect_to merchants_path
    else
      flash[:notice] = 'This merchant has items and cannot be deleted!'
      redirect_to merchant_path
    end
  end

  private

  def local_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def set_merchant
    @merchant ||= Merchant.find(params[:id])
  end
end
