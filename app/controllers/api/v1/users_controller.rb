class Api::V1::UsersController < ApplicationController 

  def create 
    user = User.new(user_params)
    user.create_api_key

    if user.save 
      render json: UserSerializer.new(user), status: :created
    else 
      render json: { errors: user.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  private 

  def user_params
    params.permit(:name, :email)
  end
end