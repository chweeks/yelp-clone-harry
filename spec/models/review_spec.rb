require 'spec_helper'

describe Review, type: :model do
  it 'is invalid if the rating is not 1..5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end
