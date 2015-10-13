class ReviewsController < ApplicationController

  def new
    find_restaurant
    @review = Review.new
  end

  def create
    find_restaurant
    @restaurant.reviews.create(review_params)
    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

end
