class ReviewsController < ApplicationController

  def new
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:item_id])
    review = item.reviews.create(review_params)
    if review.id.nil?
      flash[:alert] = "Please fill in all fields."
      redirect_to "/items/#{item.id}/reviews/new"
    else
      redirect_to "/items/#{item.id}"
    end
  end

  private
  def review_params
    params.permit(:title, :rating, :content)
  end
end
