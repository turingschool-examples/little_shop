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

  def edit
    @item = Item.find(params[:item_id])
    @review = Review.find(params[:id])
  end

  def update
    item = Item.find(params[:item_id])
    Review.find(params[:id]).update(review_params)

    redirect_to "/items/#{item.id}"
  end

  def destroy
    item = Item.find(params[:item_id])
    Review.destroy(params[:id])
    redirect_to "/items/#{item.id}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content)
  end
end
