class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end


  private

  def item_params
    params.permit(:title, :content, :rating, :item_id)
  end
end