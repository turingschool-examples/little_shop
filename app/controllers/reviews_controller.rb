class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @item.reviews.new
  end

  def create
    item = Item.find(params[:item_id])
    review = item.reviews.new(review_params)
    if review.save
      redirect_to "/items/#{item.id}"
    else
      render :new
    end
  end

  private

  def review_params
    params.permit(:title, :content, :rating)
  end
end
