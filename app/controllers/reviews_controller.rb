class ReviewsController < ApplicationController

  def new
    find_restaurant
    @review = Review.new
  end

  def create
    find_restaurant
    review = @restaurant.reviews.create(review_params)
    if review.save
      redirect_to restaurants_path
    else
      redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

end
