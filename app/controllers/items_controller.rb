class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_merchant, only: [:new, :create]
  before_action :destroy_reviews, only: [:destroy]

  def index
    if params[:merchant_id]
      set_merchant
      @items = @merchant.items
    else
      @items = Item.all
    end
  end

  def show
    # binding.pry
    if params[:sort] == nil
      @reviews = @item.reviews
    elsif params[:sort] == 'highest'
      @reviews = @item.reviews.order('rating desc')
    elsif params[:sort] == 'lowest'
      @reviews = @item.reviews.order(:rating)
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = @merchant.items.new(local_params)
    if @item.save
      redirect_to merchant_items_path(@merchant)
    else
      flash_message
      render :new
    end
  end

  def edit
  end

  def update
    if local_params.values.any? {|input| input == ''}
      flash_message
      render :edit
    else
      @item.update(local_params)
      redirect_to item_path(@item)
    end
  end

  def destroy
    if @item.orders.empty?
      @item.destroy
      redirect_to items_path
    else
      flash[:notice] = 'This item has been ordered and cannot be deleted!'
      redirect_to item_path
    end
  end

  private

  def local_params
    params.permit(:name, :description, :price, :image, :inventory)
  end

  def set_item
    @item ||= Item.find(params[:id])
  end

  def destroy_reviews
    @item.reviews.destroy_all
  end
end
