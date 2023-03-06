class Api::V1::FavoritesController < ApplicationController 

  def create 
    if (user = User.find_by(api_key: params[:api_key]))
      favorite = user.favorites.new(favorite_params)
      if favorite.save
        render json: { success: "Favorite added successfully" }, status: :created
      else 
        render json: { errors: favorite.errors.full_messages.to_sentence }, status: :bad_request
      end
    else 
      render json: { errors: "No matching user for this api_key" }, status: :not_found
    end 
  end

  private 

  def favorite_params 
    params.permit(:country, :recipe_link, :recipe_title)
  end
end