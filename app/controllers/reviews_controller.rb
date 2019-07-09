class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_item, only: [:new, :create, :edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = @item.reviews.new(review_params)
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
    if review_params.values.any? {|input| input == ''}
      flash_message
      render :edit
    else
      @review.update(review_params)
      redirect_to item_path(@item)
    end
  end

  def destroy
    @review.destroy
    redirect_to item_path(@item)
  end

  private

  def flash_message
    if review_params[:title] == ''
      flash.now[:notice] = 'Missing title!'
    elsif review_params[:content] == ''
      flash.now[:notice] = 'Missing review message!'
    elsif review_params[:rating] == ''
      flash.now[:notice] = 'Missing rating!'
    end
  end

  def review_params
    params.permit(:title, :content, :rating)
  end

  def set_review
    @review ||= Review.find(params[:id])
  end

  def set_item
    @item ||= Item.find(params[:item_id])
  end
end
