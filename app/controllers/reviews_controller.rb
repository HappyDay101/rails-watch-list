class ReviewsController < ApplicationController
  before_action :set_list

  def new
    @review = @list.reviews.build
  end

  def create
    @review = @list.reviews.build(review_params)

    if @review.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace('reviews', partial: 'reviews/new', locals: { review: @list.reviews.build }) }
        format.html { redirect_to @list, notice: 'Review was successfully added.' }
      end
    else
      render :new
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def review_params
    params.require(:review).permit(:comment)
  end
end
