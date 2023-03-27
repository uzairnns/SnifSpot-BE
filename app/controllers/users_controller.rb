class UsersController < ApplicationController
  
  def create
    user = User.new(user_params)

    if user.save
      token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
      render json: { token: token }
    else
      render json: { error: user.errors.objects.first.full_message }
    end
  end
  
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id }, 'secret')
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
  
  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :name)
  end
end
