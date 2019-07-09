class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_item, only: [:new, :create, :edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = @item.reviews.new(local_params)
    if @review.save
      redirect_to item_path(@item)
    else
      flash_message
      render :new
    end
  end

  def edit
  end

  def update
    if local_params.values.any? {|input| input == ''}
      flash_message
      render :edit
    else
      @review.update(local_params)
      redirect_to item_path(@item)
    end
  end

  def destroy
    @review.destroy
    redirect_to item_path(@item)
  end

  private

  def local_params
    params.permit(:title, :content, :rating)
  end

  def set_review
    @review ||= Review.find(params[:id])
  end
end
