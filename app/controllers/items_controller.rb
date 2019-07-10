class ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @reviews = Review.where(item_id: params[:id])

  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = @merchant.items.create(item_params)
    if item.id.nil?
      flash[:alert] = item.errors.full_messages.to_sentence
      render :new
    else
      redirect_to merchant_items_path(@merchant)
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if item_params.values.any? {|value| value.empty? }
      flash[:alert] = @item.errors.full_messages.to_sentence
      render :edit
    else
      redirect_to item_path(@item)
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.item_orders.include?(params[:id])
      flash[:alert] = "This item has pending orders, cannot be deleted."
      redirect_to "/items/#{item.id}"
    else
      Item.destroy(params[:id])
      redirect_to items_path
    end
  end

  private

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end
end
