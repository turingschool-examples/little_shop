class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_merchant, only: [:new, :create]

  def index
    if params[:merchant_id]
      set_merchant
      @items = @merchant.items
    else
      @items = Item.all
    end
  end

  def show
    @reviews = @item.reviews
  end

  def new
    @item = Item.new
  end

  def create
    @merchant.items.create(item_params)
    redirect_to merchant_items_path(@merchant)
  end

  def edit
  end

  def update
    @item.update(item_params)
    redirect_to item_path(@item)
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end

  def set_item
    @item ||= Item.find(params[:id])
  end

  def set_merchant
    @merchant ||= Merchant.find(params[:merchant_id])
  end
end
