class ItemsController < ApplicationController
  before_action :get_item, only: [:show, :edit, :update, :destroy]
  before_action :get_merchant, only: [:new, :create]

  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @items = Item.all
    end
  end

  def show
    @reviews = Review.where(item_id: params[:id])
  end

  def new
  end

  def create
    item = @merchant.items.create(item_params)
    if item.id.nil?
      flash[:alert] = item.errors.full_messages.to_sentence
      render :new
    else
      redirect_to merchant_items_path(@merchant)
    end
  end

  def edit
  end

  def update
    @item.update(item_params)
    if item_params.values.any? { |value| value.empty? }
      flash[:alert] = @item.errors.full_messages.to_sentence
      render :edit
    else
      redirect_to item_path(@item)
    end
  end

  def destroy
    if @item.item_orders.uniq.include?(params[:id].to_i)
      flash[:alert] = "This item has pending orders, cannot be deleted."
      redirect_to item_path(@item)
    else
      Item.destroy(params[:id])
      redirect_to items_path
    end
  end

  private

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end

  def get_item
    @item = Item.find(params[:id])
  end

  def get_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
