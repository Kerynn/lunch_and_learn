class RecipeFacade 

  def self.get_all_recipes(country_name)
    recipes = RecipeService.recipe_search(country_name)
    recipes[:hits].map do |recipe_data|
      Recipe.new(recipe_data)
    end
  end
end