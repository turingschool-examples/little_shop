class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @item.reviews.new
  end

  def create
    @item = Item.find(params[:item_id])
    review = @item.reviews.new(review_params)
    if review.save
      redirect_to "/items/#{@item.id}"
    else
      flash.now[:error] = "Review not created; required field(s) missing!"
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to item_path(@review.item.id)
  end

  private

  def review_params
    params.permit(:title, :content, :rating)
  end
end
