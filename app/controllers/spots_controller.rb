class SpotsController < ApplicationController
  before_action :authenticate_user , only: [:create, :update]
  before_action :find_spot, only: [:update, :show]
  before_action :upload_images, only: [:create]
  before_action :validate_user, only: [:update]
  
  
  def index
    spots = Spot.all
    spot = spots.map do |sp|
      {
        spot: sp,
        reviews: sp.reviews.count,
      }
    end
    render json: {spots: spot}
  end
  
  def show
    render json: {spot: @spot, reviews: @spot.reviews}
  end
  
  def create
    spot = Spot.new(spot_params)
    spot.user_id = @current_user_id
    spot.image_url = @url
    if spot.save
      render json: {message: 'Spot created successfully'}, status: 200
    else
      render json: {message: 'Spot not save', err: spot.errors.objects.first.full_message}, status: 422
    end
  end
  
  def update
    if @spot.update(spot_params)
      render json: {message: 'Spot updated successfully'}, status: 200
    else
      render json: {message: 'Spot not update', err: @spot.errors.objects.first.full_message}, status: 422
    end
  end
  
  private
  
  def spot_params
    params.permit(:title, :description, :price)
  end
  
  def find_spot
    @spot = Spot.find_by(id: params[:id])
    render json: {message: 'Spot not found'}, status: 422 if @spot.nil?
  end
  
  def validate_user
    render json: {message: 'unauthorized'}, status: 422 unless @spot.user_id.eql? @current_user_id
  end
  
  def upload_images
    @url = []
    images = Array.wrap(params[:images])
    images&.each do |image|
      status = Cloudinary::Uploader.upload(image)
      @url << status['url']
    end
  end
end
