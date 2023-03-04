require 'rails_helper'

RSpec.describe RecipeFacade do 
  before :each do 
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?type=public&q=italy&app_id=#{ENV['recipe_app_id']}&app_key=#{ENV['recipe_app_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/recipe_response.json'), headers: {})
  end

  it 'can return a collection of recipe objects' do 
    recipes = RecipeFacade.get_all_recipes('italy')

    expect(recipes).to be_an Array
    recipes.each do |recipe|
      expect(recipe).to be_an_instance_of(Recipe)
    end
  end
end