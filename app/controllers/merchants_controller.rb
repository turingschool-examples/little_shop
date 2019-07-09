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
    # binding.pry
    if merchant_params[:zip].to_s.length != 5 || merchant_params[:zip].to_s != merchant_params[:zip].to_i.to_s
      flash.now[:notice] = 'Please enter a valid zip code.'
      render :edit
    else
      if merchant_params.values.any? {|input| input == ''}
        flash_message
        render :edit
      else
        @merchant.update(merchant_params)
        redirect_to merchant_path(@merchant)
      end
    end
  end

  def destroy
    @merchant.destroy
    redirect_to merchants_path
  end

  private

  def flash_message
    case
    when merchant_params[:name] == ''
      flash.now[:notice] = 'Missing name!'
    when merchant_params[:address] == ''
      flash.now[:notice] = 'Missing address!'
    when merchant_params[:city] == ''
      flash.now[:notice] = 'Missing city!'
    when merchant_params[:state] == ''
      flash.now[:notice] = 'Missing state!'
    end
  end

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def set_merchant
    @merchant ||= Merchant.find(params[:id])
  end
end
