class ReviewsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews
    # redirect_to item_path(@item.id)

  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.permit(:title, :content, :rating, :item_id)
  end
end
