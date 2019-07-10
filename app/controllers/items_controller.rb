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
    merchant = Merchant.find(params[:merchant_id])
    merchant.items.create(item_params)

    redirect_to merchant_items_path
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)

    redirect_to item_path
  end

  def destroy
    Item.destroy(params[:id])

    redirect_to items_path
  end

  private

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end
end
