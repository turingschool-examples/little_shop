class ReviewsController < ApplicationController
  before_action :get_item, only: [:new, :create, :edit, :update, :destroy]
  before_action :get_review, only: [:edit, :update]

  def new
  end

  def create
    review = @item.reviews.create(review_params)
    if review.id.nil?
      flash[:alert] = "Please fill in all fields."
      redirect_to "/items/#{@item.id}/reviews/new"
    else
      redirect_to item_path(@item)
    end
  end

  def edit
  end

  def update
    @review.update(review_params)
    if @review.content.empty? || @review.title.empty?
      flash[:alert] = "Please fill in all fields."
      redirect_to "/items/#{@item.id}/reviews/#{@review.id}/edit"
    else
      redirect_to item_path(@item)
    end
  end

  def destroy
    Review.destroy(params[:id])
    redirect_to item_path(@item)
  end

  private

  def review_params
    params.permit(:title, :rating, :content)
  end

  def get_item
    @item = Item.find(params[:item_id])
  end

  def get_review
    @review = Review.find(params[:id])
  end
end
