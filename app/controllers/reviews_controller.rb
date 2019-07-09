class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @item = Item.find(params[:item_id])
  end

  def create
    review = Review.create(review_params)
    redirect_to "/items/#{review.item_id}"
  end

  def review_params
    params.permit(:title, :content, :rating, :item_id)
  end

end
