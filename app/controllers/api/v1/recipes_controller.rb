class Api::V1::RecipesController < ApplicationController 

  def index 
    if params[:country]
      results = RecipeFacade.get_all_recipes(params[:country])
    else 
      random_country = CountryFacade.random_country 
      results = RecipeFacade.get_all_recipes(random_country.name)
    end

    render json: RecipeSerializer.new(results)
  end
end