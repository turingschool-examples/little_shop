class ReviewsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:item_id])
    item.reviews.create!(review_params)
    redirect_to "/items/#{item.id}"
  end

    def edit
      @review = Review.find(params[:id])
    end

    # def update
    #   review = Review.find(params[:id])
    #   review.update(review_params)
    #   redirect_to "/items/#{review.item_id}"
    # end

    def destroy
      Review.destroy(params[:id])
      @item = Item.find(params[:item_id])
      redirect_to "/items/#{@item.id}"
    end

  private

  def review_params
    params.permit(:title, :content, :rating, :item_id)
  end
end
