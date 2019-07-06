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
    @reviews = @item.reviews
  end

  def new
    @item = Item.new
  end

  def create
    @item = @merchant.items.new(item_params)
    if @item.save
      redirect_to merchant_items_path(@merchant)
    else
      case
      when item_params[:name] == ''
        flash[:notice] = 'Missing name!'
      when item_params[:description] == ''
        flash[:notice] = 'Missing description!'
      when item_params[:price] == ''
        flash[:notice] = 'Missing price!'
      when item_params[:image] == ''
        flash[:notice] = 'Missing image!'
      when item_params[:inventroy] == ''
        flash[:notice] = 'Missing inventroy!'
      end
      render :new
    end
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

  def destroy_reviews
    @item.reviews.destroy_all
  end
end
