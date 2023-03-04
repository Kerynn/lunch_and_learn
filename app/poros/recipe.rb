class Recipe 
  attr_reader :title,
              :url,
              :image,
              :country

  def initialize(recipe_data, country_name)
    @title = recipe_data[:recipe][:label]
    @url = recipe_data[:recipe][:url]
    @image = recipe_data[:recipe][:image]
    @country = country_name
  end
end