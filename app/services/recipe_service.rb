class RecipeService 

  def self.recipe_search(search_query)
    parse(conn.get("/api/recipes/v2?q=#{search_query}"))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn 
    Faraday.new(url: 'https://api.edamam.com') do |f|
      f.params['type'] = "public"
      f.params['app_id'] = ENV['recipe_app_id']
      f.params['app_key'] = ENV['recipe_app_key']
    end
  end
end