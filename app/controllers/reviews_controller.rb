class ReviewsController < ApplicationController
  before_action :set_item, only: [:new, :create]

  def new
    @review = Review.new
  end

  def create
    @review = @item.reviews.create!(review_params)
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
