class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  def authenticate_user
    header = request.headers['Token']
    if header
      token = header.split(' ').last
      begin
        decoded = JWT.decode(token, Rails.application.secrets.secret_key_base)
        @current_user_id = decoded[0]['user_id']
      rescue JWT::DecodeError
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { error: 'Token not found' }, status: :unauthorized
    end
  end
end
