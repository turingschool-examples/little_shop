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

  def edit
    @item = Item.find(params[:item_id])
    @review = @item.reviews.find(params[:review_id])
  end

  def update
    @item = Item.find(params[:item_id])
    @review = @item.reviews.find(params[:review_id])
      if @review.update_attributes(review_params)
        flash[:notice] = "Review Updated!"
        redirect_to "/items/#{@item.id}"
      else
        flash[:notice] = "Review could not be updated, please fill in all fields."
        render :edit
      end
  end

  def destroy
    @item = Item.find(params[:item_id])
    @review = @item.reviews.find(params[:review_id])
    @review.destroy
    redirect_to "/items/#{@item.id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :body)
  end

end
