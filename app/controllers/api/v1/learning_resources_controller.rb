class Api::V1::LearningResourcesController < ApplicationController 

  def index 
    render json: LearningResourcesSerializer.new(LearningResourcesFacade.search_resources(params[:country]))
  end
end