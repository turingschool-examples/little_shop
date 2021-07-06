class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
    @total_merchant_items = @merchant.total_merchant_items
    @merchant_average_price = @merchant.merchant_average_price
    @distinct_cities = @merchant.distinct_cities
  end

  def new

  end

  def create
    @merchant = Merchant.create(merchant_params)
    if @merchant.id.nil?
      flash.now[:error] = @merchant.errors.full_messages.to_sentence
      render :edit
    else
      flash[:success] = "#{@merchant.name} has been created!"
      redirect_to "/merchants"
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

    def update
      @merchant = Merchant.find(params[:id])
       @merchant.update(merchant_params)
      if @merchant.save
        flash[:success] = "#{@merchant.name} has been updated!"
      redirect_to "/merchants/#{@merchant.id}"
     else
       flash.now[:error] = @merchant.errors.full_messages.to_sentence
         render :edit
      end
    end

  def destroy
    Merchant.destroy(params[:id])
    redirect_to '/merchants'
  end

  private

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
