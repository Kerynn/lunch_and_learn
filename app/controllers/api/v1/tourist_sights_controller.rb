class Api::V1::TouristSightsController < ApplicationController 

  def index 
    render json: TouristSightSerializer.new(TourismFacade.get_tourist_sights(params[:country]))
  end
end