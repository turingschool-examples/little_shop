class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_item, only: [:new, :create, :edit, :update]

  def new
    @review = Review.new
  end

  def create
    @review = @item.reviews.new(review_params)
    if @review.save
      redirect_to item_path(@item)
    else
      flash[:notice] = "Merchant not created! Bad zip code."
      render :new
    end
  end

  def edit
  end

  def update
    @review.update(review_params)
    redirect_to item_path(@item)
  end

  private

  def review_params
    params.permit(:title, :content, :rating)
  end

  def set_review
    @review ||= Review.find(params[:id])
  end

  def set_item
    @item ||= Item.find(params[:item_id])
  end
end
