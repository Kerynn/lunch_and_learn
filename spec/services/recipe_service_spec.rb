require 'rails_helper'

RSpec.describe RecipeService do 
  before :each do 
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?type=public&q=italy&app_id=#{ENV['recipe_app_id']}&app_key=#{ENV['recipe_app_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/recipe_response.json'), headers: {})
  end

  it 'can return the searched recipe data' do 
    response = RecipeService.recipe_search('italy')

    expect(response).to be_a Hash
    expect(response).to have_key(:count)
    expect(response).to have_key(:hits)
    expect(response[:hits]).to be_an Array
    expect(response[:hits][0]).to have_key(:recipe)
    expect(response[:hits][0][:recipe]).to have_key(:uri)
    expect(response[:hits][0][:recipe]).to have_key(:label)
    expect(response[:hits][0][:recipe][:label]).to be_a String
    expect(response[:hits][0][:recipe]).to have_key(:image)
    expect(response[:hits][0][:recipe][:image]).to be_a String
    expect(response[:hits][0][:recipe]).to have_key(:images)
    expect(response[:hits][0][:recipe]).to have_key(:url)
    expect(response[:hits][0][:recipe]).to have_key(:uri)
    expect(response[:hits][0][:recipe]).to have_key(:ingredients)
    expect(response[:hits][0][:recipe][:ingredients]).to be_an Array
    expect(response[:hits][0][:recipe]).to have_key(:calories)
    expect(response[:hits][0][:recipe][:calories]).to be_a Float
  end
end