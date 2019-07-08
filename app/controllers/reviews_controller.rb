class ReviewsController < ApplicationController

  def new
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:item_id])
    review = item.reviews.new(review_params)

    if review.save
      redirect_to "/items/#{item.id}/"
    else
      flash[:review_creation_error] = "Review could not be created, please try again."
      render :new
    end

  end

  private

  def review_params
    params.permit(:title, :rating, :body)
  end

end
