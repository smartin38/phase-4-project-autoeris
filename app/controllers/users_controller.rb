class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :create]

  def index
    user = User.all
    render json: user
  end

  def create
    user = User.create(user_params) 
    if user.valid?
        payload = {user_id: user.id}
        token = encode_token(payload)
        puts token
        render json: {user: user, jwt: token}
    else
        render json: {errors: user.errors.full_messages}, status: :not_acceptable
    end
  end

  private 

  def user_params
    params.permit(:username, :password)
  end
end