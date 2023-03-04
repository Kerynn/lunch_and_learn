class Recipe 
  attr_reader :title,
              :url,
              :image

  def initialize(recipe_data)
    @title = recipe_data[:recipe][:label]
    @url = recipe_data[:recipe][:url]
    @image = recipe_data[:recipe][:image]
  end
end