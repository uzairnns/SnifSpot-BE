class ReviewsController < ApplicationController
  before_action :authenticate_user, only: [:create, :update]
  before_action :find_spot, only: [:create ]
  before_action :find_review, only: [:update]
  before_action :validate_user, only: [:update]
  
  def create
    review = @spot.reviews.new(review_params)
    review.user_id = @current_user_id
    if review.save
      render json: {message: 'Review created successfully'}, status: 200
    else
      render json: {message: 'Review not save', err: review.errors.objects.first.full_message}, status: 422
    end
  end
  
  def update
    if @review.update(review_params)
      render json: {message: 'review updated successfully'}, status: 200
    else
      render json: {message: 'review not update', err: @review.errors.objects.first.full_message}, status: 422
    end
  end
  
  private
  
  def find_spot
    @spot = Spot.find_by( id: params[:spot_id])
    render json: {message: 'Spot not found'}, status: 422 if @spot.nil?
  end
  
  def find_review
    @review = Review.find_by( id: params[:id])
    render json: {message: 'Review not found'}, status: 422 if @review.nil?
  end
  
  def validate_user
    render json: {message: 'unauthorized'}, status: 422 unless @review.user_id.eql? @current_user_id
  end
  
  def review_params
    params.permit(:body)
  end
end
