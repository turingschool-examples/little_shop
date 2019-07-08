class ReviewsController < ApplicationController

  def new
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:item_id])
    @review = item.reviews.new(review_params)

    if @review.save
      redirect_to "/items/#{item.id}/"
      flash[:notice] = "Review Created!"
    else
      flash[:notice] = "Review could not be created, please fill in all fields."
      @item = Item.find(params[:item_id])
      render :new
    end
  end

  private

  def review_params
    params.permit(:title, :rating, :body)
  end

end
